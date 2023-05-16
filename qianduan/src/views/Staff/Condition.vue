<template>
  <div class="Condition">
    <!-- 社区管理汇报 -->
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="设施名称" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="facility"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="facility=''" type="warning">重置</el-button>
    </div>

    <el-button type="primary" @click="handleAdd" style="margin:0 15px 15px 0;">新增情况汇报 <i class="el-icon-circle-plus-outline" style="font-size: 14px;"></i></el-button>
    <el-tag type="warning">请确认社区管理的工作情况并汇报</el-tag>
    <!-- Form  dialog对话框 -->
    <el-dialog title="新增情况汇报信息" :visible.sync="dialogFormVisible" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="汇报人">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="地点">
          <el-input v-model="form.place"></el-input>
        </el-form-item>
        <el-form-item label="设备">
          <el-input v-model="form.facility" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="情况">
          <el-input v-model="form.situation" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;">
      <el-table-column prop="id" label="id" width="60"></el-table-column>
      <el-table-column prop="name" label="汇报人" width="120"></el-table-column>
      <el-table-column prop="time" label="汇报时间" width="180"></el-table-column>
      <el-table-column prop="place" label="地点" width="150"></el-table-column>
      <el-table-column prop="facility" label="设备" width="150"></el-table-column>
      <el-table-column prop="situation" label="情况" width="220"></el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope" v-if="user.username === 'admin'">
          <el-popconfirm
            style="margin-left: 5px;"
            confirm-button-text='确认'
            cancel-button-text='再想想'
            icon="el-icon-info"
            icon-color="red"
            title="您确定删除吗？"
            @confirm="handleDelete(scope.row.id)"
          >
            <el-button slot="reference" size="mini" type="danger">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pageNum"
      :page-sizes="[5, 10, 15, 20]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total">
    </el-pagination>
  </div>
</template>

<script>
export default {
    name:'Condition',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        user:JSON.parse(sessionStorage.getItem("user")) || '',
        staff:'',
        facility:'',
        form:{ name:'',time:'',place:'',facility:'',situation:'' },
        dialogFormVisible: false, //新增按钮的表单对话框的显示
      }
    },
    created(){
      this.load()
    },
    methods: {
      handleSizeChange(val) {
        this.pageSize = val
        this.load()
      },
      handleCurrentChange(val) {
        this.pageNum = val
        this.load()
      },
      load(){
        this.request.get('/api/situation/page',{params:{pageNum:this.pageNum,pageSize:this.pageSize,facility:this.facility}}).then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records 
            this.total=value.data.total
          }
        })
      },
      //只有管理员能删除
      handleDelete(id) {
        this.request.delete('/api/situation/'+id).then(res=>{
          if(res.code === '200'){
            this.$message.success("删除成功")
            this.load()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //新增按钮
      handleAdd(){
        this.form={}
        this.form.name=this.user.nickname //投诉人的名字是姓名
        this.dialogFormVisible = true
      },
      //新增对话框确定
      save(){
        this.request.post('/api/situation',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{
            this.$message.error("新增/编辑失败")
          }
        })   
      }
    }
}
</script>

<style lang="less" scoped>
.Condition{
  .search{
    .el-input{
      margin: 5px 5px 10px 0;
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
}
</style>