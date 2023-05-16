<template>
  <div class="pay">
    <!-- admin设置生活缴费表 -->
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="请输入楼宇" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="building"></el-input>
      <el-input placeholder="请输入门牌号" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="doorplate"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="building='',doorplate='',resident=''" type="warning">重置</el-button>
    </div>
    <!-- 新增按钮 -->
    <el-button type="primary" @click="handleAdd" style="margin:10px 10px 10px 0;">新增缴费信息 <i class="el-icon-circle-plus-outline" style="font-size:14px;"></i></el-button>
    <!-- Form  dialog对话框 -->
    <el-dialog title="缴费信息新增/更新" :visible.sync="dialogFormVisible" width="400px">
      <el-form :model="form" label-width="100px">
        <el-form-item label="门牌号">
          <el-input v-model="form.doorplate" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="楼宇">
          <el-select v-model="form.building" placeholder="请选择类型">
            <el-option value="happyA"></el-option>
            <el-option value="happyB"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="费用类型">
          <el-select v-model="form.type" placeholder="请选择类型">
            <el-option value="水费"></el-option>
            <el-option value="物业费"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="缴费金额">
          <el-input v-model="form.money" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="是否已缴费">
          <el-select v-model="form.state">
            <el-option value="未支付"></el-option>
            <el-option value="已缴费"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false,form={}">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 批量删除按钮 -->
    <el-popconfirm style="margin-left: 5px;" confirm-button-text='确认' cancel-button-text='我再想想'
            icon="el-icon-info" icon-color="red" title="您确定批量删除这些数据吗？"  @confirm="delBatch" >
      <el-button type="danger" slot="reference" style="margin:10px 10px 10px 0;">批量删除 <i class="el-icon-delete-solid" style="font-size: 14px;"></i></el-button>
    </el-popconfirm>

    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;" @selection-change="handleSelectionChange" >
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="id" width="60"></el-table-column>
      <el-table-column prop="doorplate" label="门牌号" width="90"></el-table-column>
      <el-table-column prop="building" label="楼宇" width="90"></el-table-column>
      <el-table-column prop="type" label="费用类型" width="90"></el-table-column>
      <el-table-column prop="money" label="缴费金额" width="90"></el-table-column>
      <el-table-column prop="createTime" label="开始时间" width="110"></el-table-column>
      <el-table-column prop="payTime" label="缴费时间" width="110"></el-table-column>
      <el-table-column prop="state" label="是否已缴费" width="180">
        <template slot-scope="scope">
          <span slot="reference" v-if="scope.row.state == '未支付'" style="backgroundColor:#909399;" class="text">{{scope.row.state}}</span>
          <span slot="reference" v-else style="backgroundColor:#67C23A;" class="text">{{scope.row.state}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="220">
        <template slot-scope="scope">
          <el-button size="mini" type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm style="margin-left: 5px;" confirm-button-text='确认' cancel-button-text='我再想想'
            icon="el-icon-info" icon-color="red" title="您确定删除吗？" @confirm="handleDelete(scope.row.id)">
            <el-button slot="reference" size="mini" type="danger">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
  </el-table>

    <!-- 分页器 -->
    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
      :page-sizes="[5, 10, 15, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
    </el-pagination>
  </div>
</template>

<script>
export default {
    name:'Pay',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:10,   //页数的大小
        total:0,
        building:'',doorplate:'',
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        form:{ doorplate:'',building:'',type:'',money:'',state:'',payTime:'' },
        multipleSelection:[],   //批量选择 列表
      }
    },
    created() {
      this.load() //初始载入
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
      //获取数据库请求
      load(){
        this.request.get('/api/pay/page',
        {params:{pageNum:this.pageNum,pageSize:this.pageSize,building:this.building,doorplate:this.doorplate}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records //获取住宅信息列表
            this.total=value.data.total
          }
        })
      },
      //编辑和删除
      handleEdit(row) {
        this.form=row
        this.dialogFormVisible=true
      },
      handleDelete(id) {
        this.request.delete('/api/pay/'+id).then(res=>{
          if(res.code === '200'){
            this.$message.success("删除成功")
            this.load()
          }else{ this.$message.error("删除失败") }
        })  
      },
      //新增按钮
      handleAdd(){
        this.form={}
        this.dialogFormVisible = true
      },
      //新增/编辑对话框确定
      save(){
        if(this.form.state === '已缴费'){
          this.form.payTime = this.tool.getNowDate()
        }
        this.request.post('/api/pay',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{ this.$message.error("新增/编辑失败")}
        })   
      },
      //批量选择时
      handleSelectionChange(val){ this.multipleSelection=val },
      //批量删除按键方法
      delBatch(){
        let ids = this.multipleSelection.map(v=>v.id)  //[1,2,3,4]
          this.request.delete('api/pay/batch',{data:ids}).then(res => {
            if(res.code === '200'){
              this.$message.success("批量删除成功")
              this.load()
            }else{ this.$message.error("批量删除失败") }
          })
      }
    }
}
</script>

<style lang="less" scoped>
.pay{
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
}
.text{
  padding:5px;
  border-radius:20px;
  color:#000;
}
</style>