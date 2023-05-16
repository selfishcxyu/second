<template>
  <div class="Bill">
    <!-- 新增按钮 -->
    <el-button type="primary" @click="handleAdd" style="margin:0 15px 15px 0;">新增账单 <i class="el-icon-circle-plus-outline" style="font-size: 14px;"></i></el-button>
    <el-tag type="warning">请确认账单后在仓库管理更新物品</el-tag>
    <!-- Form  dialog对话框 -->
    <el-dialog title="新增账单信息" :visible.sync="dialogFormVisible" width="500px" @close='closeDialog'>
      <el-form :model="form" label-width="80px">
        <el-form-item label="采购人">
          <el-input v-model="form.nickname"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model.lazy="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="名称">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="数量">
          <el-input v-model="form.count" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="单价">
          <el-input v-model="form.price" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="采购凭证">
          <!-- 自动提交auto-upload属性为false时，on-success和before-upload属性会失效，我们将他们的操作移到on-change中来 -->
          <!--:http-request覆盖默认的上传行为，可以自定义上传的实现-->
          <el-upload
            class="picture-uploader" ref="upload"
            list-type="picture"
            action="http://localhost:90/file/upload"
            :before-upload="beforeUpload"
            :on-exceed="handleExceed"
            :limit="1"
            :on-success="handleSuccess"
          >
            <el-button slot="trigger" size="small" type="primary"><i class="el-icon-plus"></i>选择上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件,且不超过1MB</div>
          </el-upload>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.note" autocomplete="off"></el-input>
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
      <el-table-column prop="nickname" label="采购人" width="100"></el-table-column>
      <el-table-column prop="phone" label="电话" width="120"></el-table-column>
      <el-table-column prop="name" label="名称" width="100"></el-table-column>
      <el-table-column prop="count" label="数量" width="70"></el-table-column>
      <el-table-column prop="price" label="单价" width="70"></el-table-column>
      <el-table-column prop="picture" label="采购凭证" width="210">
        <template slot-scope="scope">
          <el-popover placement="right" title="" trigger="click">
            <el-image slot="reference" v-if="scope.row.picture" :src="scope.row.picture" :alt="scope.row.picture" style="max-height: 200px;max-width: 200px"></el-image>
            <el-image :src="scope.row.picture"></el-image>
         </el-popover>
        </template>
      </el-table-column>
      <el-table-column prop="time" label="确认时间" width="110"></el-table-column>
      <el-table-column prop="note" label="备注" width="150"></el-table-column>
      <el-table-column prop="state" label="处理状态" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.state =='未确认'" style="backgroundColor: #909399;" class="text">{{scope.row.state}}</span> 
          <span v-else style="backgroundColor: #67C23A;" class="text">{{scope.row.state}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="190">
        <template slot-scope="scope" v-if="user.username === 'admin'"> 
          <el-popconfirm
            style="margin-left: 5px;"
            confirm-button-text='确认'
            cancel-button-text='我再想想'
            icon="el-icon-info"
            icon-color="red"
            title="是否确认账单？"
            @confirm="handleBill(scope.row.id)"
          >
            <el-button slot="reference" size="mini" type="info" v-if="scope.row.state=='未确认'">确认 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
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
    name:'Bill',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        user:JSON.parse(sessionStorage.getItem("user")) || '',
        staff:'',
        form:{ name:'',nickname:'',phone:'',count:'',price:'',total:'',picture:'',note:'' },
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        fileList: []//存放上传文件
      }
    },
    created(){
      this.load()
    },
    methods: {
      handleSizeChange(val) {
        this.pageSize = val
        this.loadTwo()
      },
      handleCurrentChange(val) {
        this.pageNum = val
        this.loadTwo()
      },
      async load(){
        //员工通过手机号获取自己提交的账单，管理员获取所有
        if(this.user.level !== 'admin'){
          const res = await this.getStaffPhone()
          this.staff = res.data
        }
        this.loadTwo()
      },
      loadTwo(){
        // if是员工，只获取自己的，管理员获取全部
        this.request.get('/api/bill/page',{params:{pageNum:this.pageNum,pageSize:this.pageSize, phone: this.user.level === 'admin' ? '' : this.staff.phone}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records 
            this.total=value.data.total
          }
        })
      },
      getStaffPhone(){
        //员工根据自己的id对应员工表的pid以获取对应员工表的id
        return this.request.get('/api/staff/pid/'+ this.user.id)
      },
      //除管理员，其他的新增账单需经过管理员确定
      handleBill(id) {
        this.request.post('/api/bill',{id:id,state:'已确认',time: this.tool.getNowDate()}).then(res=>{
          if(res.code === '200'){
            this.load()
          }
        })  
      },
      //只有管理员能删除
      handleDelete(id) {
        this.request.delete('/api/bill/'+id).then(res=>{
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
        this.form.nickname=this.user.nickname //投诉人的名字是姓名
        this.form.phone=this.staff.phone || ''
        this.dialogFormVisible = true
      },
      //新增对话框确定
      save(){
        this.form.total = this.form.count*this.form.price
        console.log(this.form.total);
        this.request.post('/api/bill',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{
            this.$message.error("新增/编辑失败")
          }
        })   
      },
      //上传前验证图片类型和大小
      beforeUpload(file) {
        let types = ['image/jpeg', 'image/jpg', 'image/gif', 'image/bmp', 'image/png'];
        const isImage = types.includes(file.type);
        const isEXceedSize = file.size / 1024 / 1024 < 1;
        if (!isImage) {
          this.$message.error('上传图片只能是 JPG、JPEG、gif、bmp、PNG 格式!');
          return false;
        }
        if (!isEXceedSize) {
          this.$message.error('上传图片大小不能超过 1MB!');
          return false;
        }
        return true;
      },
      // 文件数量过多时提醒
      handleExceed() {
        this.$message.error('最多支持1个附件上传' )
      },
      handleSuccess(res){
        this.$message.success("上传成功")
        this.form.picture = res
      },
      //关闭对话框，清空文件上传列表
      closeDialog(){
        this.$refs.upload.clearFiles();
      }
      
    }
}
</script>

<style lang="less" scoped>
.Bill{
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
  .picture-uploader{
    text-align: center;
    padding-bottom: 15px;
  }
  .picture-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .picture-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .text{
    color:#000;
    padding:5px;
    border-radius:20px;
  }
}
</style>