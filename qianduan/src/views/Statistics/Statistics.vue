<template>
  <div class="statistics">
    <el-row :gutter="15" style="margin-bottom: 20px">
      <el-col :span="6">
        <el-card style="color: #409eff; height: 120px; border-radius:10px; margin-bottom:10px;" shadow="hover">
          <div><i class="el-icon-user-solid"></i> 用户数量</div>
          <div style="padding: 15px;margin-top: 10px; text-align: center; font-weight: bold; font-size: 18px;">{{ user }}</div>
        </el-card>
        <el-card style="color: #E6A23C; height: 120px; border-radius:10px;" shadow="hover">
          <div><i class="el-icon-user-solid"></i> 未处理投诉数量</div>
          <div style="padding: 15px;margin-top: 10px; text-align: center; font-weight: bold; font-size: 18px;">{{ complain }}</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #409eff; height: 120px; border-radius:10px; margin-bottom:10px;" shadow="hover">
          <div><i class="el-icon-office-building"></i> 楼宇数量</div>
          <div style="padding: 15px;margin-top: 10px; text-align: center; font-weight: bold; font-size: 18px;">{{ residenceInfo.buildingNum }}</div>
        </el-card>
        <el-card  style="color: #409eff; height: 120px; border-radius:10px;" shadow="hover">
          <div><i class="el-icon-user-solid"></i> 公告数量</div>
          <div style="padding: 15px;margin-top: 10px; text-align: center; font-weight: bold; font-size: 18px;">{{ notice }}</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #409eff; height: 250px; border-radius:10px;" shadow="hover">
          <div><i class="el-icon-house"></i> 房间数量</div>
          <div class="circle_box">
            <el-progress type="circle" 
              :percentage="(residenceInfo.roomOccupy/residenceInfo.roomNum).toFixed(2) * 100"
              v-if="!isNaN((residenceInfo.roomOccupy/residenceInfo.roomNum).toFixed(1) * 100)"
              :width="180"
              :stroke-width="10"
              style="padding: 15px; margin-left:20px; font-weight: bold; font-size: 18px;"
              :show-text="false">
            </el-progress>
            <div class="circle_text">
              <p>占用/总数</p>
              <p>{{ residenceInfo.roomOccupy }} / {{ residenceInfo.roomNum }}</p>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #409eff; height: 250px; border-radius:10px;" shadow="hover">
          <div><i class="el-icon-house"></i> 车位数量</div>
          <div class="circle_box">
            <el-progress type="circle" 
              :percentage="(parkingInfo.occupy/parkingInfo.sum).toFixed(2) * 100"
              v-if="!isNaN((parkingInfo.occupy/parkingInfo.sum).toFixed(1) * 100)"
              :width="180"
              :stroke-width="10"
              style="padding: 15px; margin-left:20px; font-weight: bold; font-size: 18px;"
              :show-text="false">
            </el-progress>
            <div class="circle_text">
              <p>占用/总数</p>
              <p>{{ parkingInfo.occupy }} / {{ parkingInfo.sum }}</p>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-col :span="24" style="margin-bottom: 20px">
      <el-card shadow="hover">
        <el-statistic :title="monthTime" style="font-size:18px; color: #409eff;">
          <template slot="prefix">
            <i class="el-icon-time" style="color: blue"></i>
            {{lastMonthIncome.time}}
          </template>
        </el-statistic>
      </el-card>
    </el-col>

    <el-row :gutter="20">
      <el-col :span="8">
        <el-card shadow="hover">
          <el-statistic group-separator="," :precision="2" decimal-separator="."
             :value="lastMonthIncome.sum" :title="monthIncome" style="font-size:18px; color: #67C23A;">
            <template slot="suffix">
              <i class="el-icon-s-flag" style="color: blue"></i>
            </template>
          </el-statistic>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="hover">
          <el-statistic group-separator="," :precision="2" decimal-separator="."
             :value="lastMonthStaffOutcome.sum" :title="staffOutcome" style="font-size:18px; color: #409eff; color: #E6A23C;">
            <template slot="prefix">
              <i class="el-icon-s-flag" style="color: red"></i>
            </template>
          </el-statistic>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="hover">
          <el-statistic group-separator="," :precision="2" decimal-separator="."
             :value="lastMonthBillOutcome.sum" :title="billOutcome" style="font-size:18px; color: #409eff; color: #E6A23C;">
            <template slot="prefix">
              <i class="el-icon-s-flag" style="color: red"></i>
            </template>
          </el-statistic>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "Statistics",
  data() {
    return {
        user: '', //用户数量
        notice: '', //公告数量
        complain:'', //未处理报修数量
        residenceInfo:'',
        parkingInfo:'',
        lastMonthIncome:'',  //上月的时间time和水电物业费收入总额sum
        lastMonthStaffOutcome:'', //上月的时间time和员工工资支出总额sum
        lastMonthBillOutcome:'', //上月的时间time和账单支出总额sum
        monthTime:"时间",
        monthIncome:'上个月财务收入',
        staffOutcome:'上个月员工工资支出',
        billOutcome:'上个月账单支出',
    };
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      //获取上月收入数据
      this.request.get('/api/statistics/'+'payM').then(value => {
        if(value.code === '200'){
          this.lastMonthIncome = value.data
        }
      })
      this.request.get('/api/statistics/'+'staffM').then(value => {
        if(value.code === '200'){
          this.lastMonthStaffOutcome = value.data
        }
      })
      this.request.get('/api/statistics/'+'BillM').then(value => {
        if(value.code === '200'){
          this.lastMonthBillOutcome = value.data
        }
      })
      //获取用户数量，住宅楼宇和房间数信息，车位信息
      this.request.get("/api/user").then(value1 => {
        if (value1.code === "200") {
          this.user = value1.data.length;
        }
      })
      this.request.get("/api/residence/manage").then(value2 => {
        if(value2.code === '200'){
          this.residenceInfo = value2.data
        }
      })
      this.request.get("/api/parking/sum").then(value3 => {
        if(value3.code === '200'){
          console.log(value3);
          this.parkingInfo = value3.data
        }
      })
      //获取未处理得投诉
      this.request.get("/api/complaint/noComplaint").then(value4 => {
        if(value4.code === '200'){
          this.complain = value4.data.length
        }
      })
      this.request.get("/api/notice").then(value5 => {
        if(value5.code === '200'){
          this.notice = value5.data.length
        }
      })
    },
  },
};
</script>
    
<style lang="less" scoped>
.statistics {
  .circle_box {
    position: relative;
    text-align: center;
    .circle_text {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-40%,-40%);
    }
  }
}
</style>