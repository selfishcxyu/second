<template>
  <div>
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="请输入文件名称" style="width:200px" prefix-icon="el-icon-search" v-model.trim="name"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="name='',load()" type="warning">重置</el-button>
    </div>
    <!-- 导入-->
    <el-upload ref="upload" action="http://localhost:90/file/upload" :show-file-list="false" :on-success="onSuccess" 
               :before-upload="beforeUpload" style="display: inline-block;">
        <el-button type="primary" style="margin:10px 10px 10px 0;">文件上传 <i class="el-icon-top"></i></el-button>
    </el-upload>

    <el-dialog title="文件信息更改" :visible.sync="dialogFormVisible" width="550px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="图片名">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;">
      <!-- 可选 -->
      <el-table-column prop="id" label="id" width="100"></el-table-column>
      <el-table-column prop="name" label="文件名称" width="350"></el-table-column>
      <el-table-column prop="url" label="图片预览" width="210">
        <template slot-scope="scope">
          <el-popover placement="right" title="" trigger="click" v-if="PicReg.test(scope.row.type)">
            <el-image slot="reference" v-if="scope.row.url" :src="scope.row.url" :alt="scope.row.url" style="max-height: 120px;max-width: 120px"></el-image>
            <el-image :src="scope.row.url"></el-image>
         </el-popover>
         <el-tag v-else>非图片格式</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="type" label="文件类型" width="100"></el-table-column>
      <el-table-column prop="size" label="文件大小(kb)" width="120"></el-table-column>
      <el-table-column label="下载">
        <template slot-scope="scope">
          <el-button type="primary" @click="handleLoadFile(scope.row)">下载</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button type="primary" @click="edit(scope.row)">编辑</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pageNum"
      :page-sizes="[7, 14, 21, 28]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total">
    </el-pagination>
  </div>
</template>

<script>
export default {
    name:"Files",
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:7,   //页数的大小
        total:0,
        name:'',
        PicReg: /^(jpg|bmp|gif|ico|pcx|jpeg|tif|png|raw|tga)$/,
        dialogFormVisible: false,
        form: { id:'',name:''}
      }
    },
    created() {
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
        this.request.get('/api/file/page',{params:{pageNum:this.pageNum,pageSize:this.pageSize,name:this.name}})
        .then((value) => {
          if(value.code=='200'){
            this.tableData=value.data.records //获取文件列表
            this.total=value.data.total
          }
        })
      },
      //文件下载
      handleLoadFile(row){
        console.log(row);
        window.open(row.url)
      },
      //文件上传成功
      onSuccess(){
        this.$message.success("文件上传成功")
        this.load()
      },
      //验证大小<1mb
      beforeUpload(file) {
        const isEXceedSize = file.size / 1024 / 1024 < 1;
        if (!isEXceedSize) {
          this.$message.error('上传文件大小不能超过 1MB!');
          return false;
        }
        return true;
      },
      edit(row){
        this.form.id = row.id
        this.form.name = row.name
        this.dialogFormVisible = true
      },
      save(){
        this.request.post("/api/file/update",this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("操作成功")
            this.load()
            this.dialogFormVisible = false
          }else{
            this.$message.error("error")
          }
        })
      },
    }
}
</script>

<style lang="less" scoped>
.block{
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
}
  
</style>