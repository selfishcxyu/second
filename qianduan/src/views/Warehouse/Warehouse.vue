<template>
  <div class="Warehouse">
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="物品名称" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="name"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="name=''" type="warning">重置</el-button>
    </div>

    <div style="margin-bottom: 15px;">
      <el-button type="primary" @click="handleAdd">新增物品 <i class="el-icon-circle-plus-outline" style="font-size: 14px;"></i></el-button>
        <el-tag style="margin: 15px 50px 0 15px;">请确认物品变更无误</el-tag>

        <el-button type="primary" size="medium" @click="openHistoryInfo">GO!</el-button>
        <el-tag style="margin: 15px 0 0 15px;">前往仓库物品历史变更信息...</el-tag>

        <el-drawer
          title="仓库历史信息"
          :visible.sync="drawer"
          size="50%"
          >
          <div>
            <el-table :data="tableData2" stripe border style="width: 100%; margin-bottom: 15px;">
              <el-table-column prop="id" label="id" width="55"></el-table-column>
              <el-table-column prop="name" label="汇报人" width="90"></el-table-column>
              <el-table-column prop="time" label="汇报时间" width="140"></el-table-column>
              <el-table-column prop="place" label="地点" width="90"></el-table-column>
              <el-table-column prop="facility" label="设备" width="120"></el-table-column>
              <el-table-column prop="situation" label="情况" width="140"></el-table-column>
              <el-table-column label="操作" width="132">
                <template slot-scope="scope" v-if="user.level === 'admin'">
                  <el-popconfirm
                    style="margin-left: 5px;"
                    confirm-button-text='确认'
                    cancel-button-text='再想想'
                    icon="el-icon-info"
                    icon-color="red"
                    title="您确定删除吗？"
                    @confirm="handleDeleteH(scope.row.id)"
                  >
                    <el-button slot="reference" size="mini" type="danger">删除 <i class="el-icon-remove-outline"></i></el-button>
                  </el-popconfirm>
                </template>
              </el-table-column>
            </el-table>

            <el-pagination
              @size-change="handleSizeChange2"
              @current-change="handleCurrentChange2"
              :current-page="pageNum2"
              :page-sizes="[5, 10, 15, 20]"
              :page-size="pageSize2"
              layout="total, sizes, prev, pager, next, jumper"
              :total="total2">
            </el-pagination>
          </div>
        </el-drawer>
    </div>

    <el-dialog title="物品信息" :visible.sync="dialogFormVisible" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="名称">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="数量">
          <el-input v-model="form.count"></el-input>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description"></el-input>
        </el-form-item>
        <el-form-item label="使用情况" v-if="edit">
          <el-select v-model="WareUse.state" placeholder="请选择物品状态" style="margin-bottom: 10px;">
            <el-option value="使用"></el-option>
            <el-option value="增添"></el-option>
          </el-select>
          <el-input v-model="WareUse.count" placeholder="请输入物品数量"></el-input>
        </el-form-item>
      </el-form>
     
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

      <!-- data -->
      <el-table :data="tableData1" stripe border style="width: 100%; margin-bottom: 15px;">
        <el-table-column prop="id" label="编号" width="87"></el-table-column>
        <el-table-column prop="name" label="名称" width="150"></el-table-column>
        <el-table-column prop="count" label="数量" width="130"></el-table-column>
        <el-table-column prop="description" label="描述" width="220"></el-table-column>
        <el-table-column label="操作" width="230">
          <template slot-scope="scope"> 
            <el-button size="mini" type="primary" @click="handleEdit(scope.row,{edit:true})">编辑 <i class="el-icon-edit"></i></el-button>
            <el-popconfirm
              style="margin-left: 5px;"
              confirm-button-text='确认'
              cancel-button-text='再想想'
              icon="el-icon-info"
              icon-color="red"
              title="您确定删除吗？"
              @confirm="handleDelete(scope.row.id)"
            >
              <el-button slot="reference" size="mini" type="danger" v-if="user.level === 'admin'">删除 <i class="el-icon-remove-outline"></i></el-button>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>

    <el-pagination
      @size-change="handleSizeChange1"
      @current-change="handleCurrentChange1"
      :current-page="pageNum1"
      :page-sizes="[5, 10, 15, 20]"
      :page-size="pageSize1"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total1">
    </el-pagination>
  </div>
</template>

<script>
export default {
    name:'Warehouse',
    data() {
      return {
        tableData1:[],
        pageNum1:1,  //当前页数
        pageSize1:5,   //页数的大小
        total1:0,
        tableData2:[],
        pageNum2:1,  //当前页数
        pageSize2:5,   //页数的大小
        total2:0,
        name:'',
        user:JSON.parse(sessionStorage.getItem("user")) || '',
        form:{ name:'',count:'',description:'' },
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        WareUse: { count:'',state:'' },
        edit:false,  //判断是编辑还是新增
        drawer: false,
      }
    },
    created() {
      this.load() //初始载入
    },
    methods: {
      handleSizeChange1(val) {
        this.pageSize1 = val
        this.load()
      },
      handleCurrentChange1(val) {
        this.pageNum1 = val
        this.load()
      },
      handleSizeChange2(val) {
        this.pageSize2 = val
        this.load()
      },
      handleCurrentChange2(val) {
        this.pageNum2 = val
        this.load()
      },
      //获取数据库请求
      load(){
        this.request.get('/api/warehouse/page',{params:{pageNum:this.pageNum1,pageSize:this.pageSize1,name:this.name}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData1=value.data.records //获取用户列表
            this.total1=value.data.total
          }
        })
      },
      handleDelete(id) {
        this.request.delete('/api/warehouse/'+id).then(res=>{
          if(res.code === '200'){
            this.$message.success("删除成功")
            this.load()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //只有管理员能删除(历史信息)
      handleDeleteH(id) {
        this.request.delete('/api/situation/'+id).then(res=>{
          if(res.code === '200'){
            this.$message.success("删除成功")
            this.getHistoryInfo()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //新增按钮
      handleAdd(){
        this.form={}
        this.dialogFormVisible = true
      },
      //编辑按钮
      handleEdit(row,obj){
        this.form=row
        this.WareUse={}
        if(obj.edit){
          this.edit = true
        }
        this.dialogFormVisible=true
      },
      //新增对话框确定
      save(){
        if(this.WareUse.state == "使用"){
          this.form.count -= this.WareUse.count
        }else if(this.WareUse.state == "增添"){
          this.form.count += (this.WareUse.count - 0)
        }
        //情况汇报处添加更改仓库信息记录
        this.request.post('/api/situation',{ name:this.user.nickname, place:"仓库",facility:this.form.name,type:'warehouse',
        situation: this.edit ? this.WareUse.state+'了'+this.WareUse.count+'件物品' : '新增新物品：'+this.form.name+' '+this.form.count+'件' },).then(res => {
          if(res.code === '200'){
            console.log(res);
          }
        })
        this.request.post('/api/warehouse',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.edit = false
            this.load()
          }else{
            this.$message.error("新增/编辑失败")
          }
        })   
      },
      openHistoryInfo(){
        this.drawer = true
        this.getHistoryInfo()
      },
      getHistoryInfo(){
        this.request.get('/api/situation/page',{params:{pageNum:this.pageNum2,pageSize:this.pageSize2,type:'warehouse'}}).then((value) => {
          if(value.code === '200'){
            this.tableData2=value.data.records 
            this.total2=value.data.total
          }
        })
      }
    }
}
</script>

<style lang="less" scoped>
.Warehouse{
  .search{
    .el-input{
      margin-right: 5px;
    }
  }
  .el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
  .el-tooltip__popper{
    display: none;
  }
  .el-popover{
    border: 1px solid #333;
    min-height: 150px;
  }
  //更改抽屉背景色和标题样式
  /deep/.el-drawer.rtl {
    background: #6aabc5;
  }
  /deep/.el-drawer__header{
    color:#fff;
    font-size:22px;
  }
}
</style>