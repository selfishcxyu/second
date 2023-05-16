<template>
  <div class="residence">
    <!-- 居民查看未购买或租用的房源信息 -->
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="请输入楼宇" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="building"></el-input>
      <el-input placeholder="请输入门牌号" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="doorplate"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="building='',doorplate=''" type="warning">重置</el-button>
      <el-tag style="margin-left: 20px;">个人房产请前往个人信息查看...</el-tag>
    </div>
    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;" >
      <el-table-column prop="doorplate" label="门牌号" width="100"></el-table-column>
      <el-table-column prop="building" label="楼宇" width="100"></el-table-column>
      <el-table-column prop="size" label="规格" width="100"></el-table-column>
      <el-table-column prop="price" label="价格/w" width="100"></el-table-column>
      <el-table-column prop="area" label="面积/m²" width="100"></el-table-column>
      <el-table-column prop="note" label="备注" :show-overflow-tooltip='true'>
        <template slot-scope="scope">
          <el-popover placement="top" width="400" trigger="hover">
						<span>备注:{{scope.row.note}}</span>
						<span slot="reference">{{scope.row.note ? scope.row.note : ''}}</span>
					</el-popover>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope">
          <el-popconfirm
            style="margin-left: 5px;"
            confirm-button-text='确认'
            cancel-button-text='我再想想'
            icon="el-icon-info"
            icon-color="red"
            title="您确定购买吗？"
            @confirm="handlePurchase(scope.row)"
          >
            <el-button slot="reference" size="mini" type="primary">购买 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
  </el-table>

    <!-- 分页器 -->
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
    name:'ResidenceUser',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        building:'',
        doorplate:'',
        req:{
          id:JSON.parse(sessionStorage.getItem("user")).id || null,
          nickname:JSON.parse(sessionStorage.getItem("user")).nickname || '',
        },
        dialogFormVisible: false, //新增按钮的表单对话框的显示
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
      //获取未出租或出售的房源信息
      load(){
        this.request.get('/api/residence/page',
        {params:{pageNum:this.pageNum,pageSize:this.pageSize,building:this.building,doorplate:this.doorplate,other:'other'}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records
            this.total=value.data.total
            this.$message.success("get residence success")
          }
        })
      },
      handlePurchase(row) {
        this.request.post('/api/residence',{id:row.id,req:JSON.stringify(this.req)}).then(res=>{
          if(res.code === '200'){
            this.$message.success("等待核实")
          }else{
            this.$message.error("error")
          }
        })  
      },
    }
}
</script>

<style lang="less" scoped>
.residence{
  .search{
    margin-bottom: 15px;
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


</style>