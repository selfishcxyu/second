<template>
  <div class="person">
    <el-row type="flex" :gutter="15">
        <el-col :span="10">
            <el-card style="width: auto;">
                <el-upload
                    class="avatar-uploader"
                    action="http://localhost:90/file/upload"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                >
                    <img v-if="form.avatar" :src="form.avatar" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                <el-form :model="form" label-width="80px" size="small">
                    <el-form-item label="用户名">
                        <el-input v-model="form.username" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="昵称">
                        <el-input v-model="form.nickname" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="性别">
                        <el-select v-model="form.gender" placeholder="请选择性别">
                            <el-option value="男"></el-option>
                            <el-option value="女"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="邮箱">
                    <el-input v-model.trim="form.email" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="电话">
                        <el-input v-model.trim="form.phone" autocomplete="off" maxlength="11"></el-input>
                    </el-form-item>
                     <el-form-item label="身份证">
                        <el-input v-model.trim="form.idcard" autocomplete="off" maxlength="18"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="saveFormatReg" style="margin-right:20px">提交保存</el-button>
                        <el-button type="info" @click="changePassword">修改密码</el-button>
                    </el-form-item>
                </el-form>
            </el-card>
        </el-col>

        <el-col :span="14">
            <el-card style="width: 700px;margin-bottom:20px;">
                <h2 style="margin-bootom:10px;">我的房源信息</h2>
                <el-table :data="ResidenceData" border style="width: 100%" >
                    <el-table-column prop="id" label="id" width="55"></el-table-column>
                    <el-table-column prop="doorplate" label="门牌号" width="80"></el-table-column>
                    <el-table-column prop="building" label="楼宇" width="80"></el-table-column>
                    <el-table-column prop="size" label="规格" width="80"></el-table-column>
                    <el-table-column prop="price" label="价格" width="80"></el-table-column>
                    <el-table-column prop="area" label="面积/m²" width="80"></el-table-column>
                    <el-table-column prop="time" label="入住时间" width="110"></el-table-column>
                    <el-table-column prop="note" label="备注" :show-overflow-tooltip='true'>
                        <template slot-scope="scope">
                            <el-popover placement="top" width="400" trigger="hover">
                                <span>备注:{{scope.row.note}}</span>
                                <span slot="reference">{{scope.row.note ? scope.row.note : ''}}</span>
                            </el-popover>
                        </template>
                    </el-table-column>
                </el-table>
            </el-card>
            <el-card style="width: 700px;">
                <h2 style="margin-bootom:10px;">我的车位信息</h2>
                <el-table :data="ParkingData" border style="width: 100%" >
                    <el-table-column prop="id" label="id" width="55"></el-table-column>
                    <el-table-column prop="number" label="车位编号" width="180" style="text-align:center;"></el-table-column>
                    <el-table-column prop="building" label="楼宇" width="180"></el-table-column>
                    <el-table-column prop="state" label="车位状态" width="150">
                        <template slot-scope="scope">
                        <span v-if="scope.row.state =='空闲'" style="backgroundColor:#909399;" class="text">{{scope.row.state}}</span> 
                        <span v-else style="backgroundColor:#67C23A;" class="text">{{scope.row.state}}</span>
                        </template>
                    </el-table-column>
                </el-table>
            </el-card>
        </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
    name:'Person',
    data () {
        return {
            ResidenceData:[],
            ParkingData:[],
            form:{},
            user:JSON.parse(sessionStorage.getItem("user")) || '',
            phoneReg: /^1[3|4|5|6|7|8|9]{1}[0-9]{9}/,  //纯数字、1开头、共11位
            emailReg: /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/, 
            idcardReg: /^([1-6][1-9]|50)\d{4}(18|19|20)\d{2}((0[1-9])|10|11|12)(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/,
            idcardReg2: /^([1-6][1-9]|50)\d{4}\d{2}((0[1-9])|10|11|12)(([0-2][1-9])|10|20|30|31)\d{3}$/,
        }
    },
    created() {
        this.load()
    },
    methods: {
        //保存个人信息
        save(){
            this.request.post('/api/user',this.form).then(res => {
                if(res.code === '200'){
                    this.$message.success("保存成功")
                    //更新浏览器存储的用户信息
                    this.request.get('/api/user/username/'+this.user.username).then(value => {
                        if(value.code === '200'){
                            let response = value.data
                            response.token = this.user.token
                            sessionStorage.setItem("user",JSON.stringify(response))
                            //保存到数据库后，更新Header信息
                            this.$bus.$emit("update")
                        }
                    })
                }else{
                    this.$message.error("编辑失败")
                }
            })   
        },
        saveFormatReg(){
            if(this.form.idcard){
                this.form.idcard = this.form.idcard.split(' ').join('') //剔除空格
            }
            //验证手机号，邮箱，身份证格式
            if(!this.emailReg.test(this.form.email)){
                this.$message.error("邮箱格式错误！")
                return
            }
            if(!this.phoneReg.test(this.form.phone)){
                this.$message.error("手机号格式错误！")
                return
            }
            if(!(this.idcardReg.test(this.form.idcard) || this.idcardReg2.test(this.form.idcard))){
                this.$message.error("身份证格式错误！")
                return
            }
            this.save()
        },
        load(){
            this.request.get('/api/user/username/'+this.user.username).then(res => {
                if(res.code === '200'){
                    this.form = res.data
                }
            })
            this.request.get("/api/residence/"+this.user.id).then(res => {
                if(res.code === '200'){
                    this.ResidenceData = res.data
                }
            })
            this.request.get("/api/parking/"+this.user.id).then(res => {
                if(res.code === '200'){
                    this.ParkingData = res.data
                }
            })
        },
        //上传头像成功的回调
        handleAvatarSuccess(res){
            this.form.avatar = res
        },
        changePassword(){
            this.$store.commit('man/tabListAdd',{
                path:'/password',
                name:"修改密码"
            })
            this.$router.push('password')
        },
    }
}
</script>

<style lang="less" scoped>
.avatar-uploader{
    text-align: center;
    padding-bottom: 15px;
}
.avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 158px;
    height: 158px;
    line-height: 158px;
    text-align: center;
  }
  .avatar {
    width: 158px;
    height: 158px;
    display: block;
  }
  .text{
  color:#000;
  padding:10px;
  border-radius:20px;
}
</style>