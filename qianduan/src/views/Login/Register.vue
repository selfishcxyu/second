<template>
    <div class="contain">
        <div class="register">
            <h1 class="title">用户注册</h1>
            <img src="@/assets/images/心海.jpg" style="width: 40px;margin-top: 40px;opacity: 0.7;" alt="">
            <el-form :rules="rules" :model="ruleForm" action="" :label-position="labelPosition" ref="ruleForm">
                <el-form-item prop="username">
                    <el-input size="medium" v-model="ruleForm.username" placeholder="  用户名" prefix-icon="el-icon-user" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input size="medium" v-model="ruleForm.password" placeholder="  密码" prefix-icon="el-icon-lock" autocomplete="off" type="password" :show-password="true" ></el-input>
                </el-form-item>
                <el-form-item prop="passwordConfirm">
                    <el-input size="medium" v-model="ruleForm.passwordConfirm" placeholder="  确认密码" prefix-icon="el-icon-lock" autocomplete="off" type="password" :show-password="true" ></el-input>
                </el-form-item>
                <el-button type="primary" @click="register" style="width: 100%; margin: 20px 20px 20px 0;">注册</el-button>
                
                <el-link type="primary" style="float: right;" @click="$router.push('/login')">返回登录...</el-link>
            </el-form>
        </div>
    </div>
</template>

<script>
export default {
    name:'Register',
    data() {
        return {
            labelPosition:'left',
            ruleForm:{
                username:'',
                password:'',
                passwordConfirm:''
            },
            rules:{
                username: [
                    { required: true, message: '请输入用户名', trigger: 'blur' },
                    { pattern:/^[0-9a-zA-Z_]{3,15}$/, message: '用户名由3到15位数字、字母或下划线组成', trigger: 'blur' }
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                    { pattern:/^[0-9a-zA-Z_]{3,20}$/, message: '密码由3到20位数字、字母或下划线组成', trigger: 'blur' }
                ],
                passwordConfirm: [
                    { required: true, message: '请确认输入的密码', trigger: 'blur' },
                    { pattern:/^[0-9a-zA-Z_]{3,20}$/, message: '密码由3到20位数字、字母或下划线组成', trigger: 'blur' }
                ],
            }
        }
    },
    methods:{
        register(){
             //提交前表单认证
            this.$refs['ruleForm'].validate((valid) => {
                if (valid) {
                    if(this.ruleForm.password !== this.ruleForm.passwordConfirm){
                        this.$message.error("两次输入的密码不一致")
                        return false
                    }
                    this.request.post('api/user/register',this.ruleForm).then(res => {
                        console.log(res);
                        if(res.code==='200'){
                            //注册成功后返回登录页面
                            this.$router.push('/login')
                            this.$message.success("register success")
                        }else{
                            this.$message.error(res.msg)
                        }
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });
        },
    }
}
</script>


<style lang="less" scoped>
    .contain{
        background: url("@/assets/images/logBG.png") no-repeat;
        background-position: center;
        height: 100vh;
        width: 100%;
        background-size: cover;
        position: fixed;
        .register{
            margin: 150px auto;
            width: 400px;
            height: 500px;
            text-align: center;
            padding: 5px 40px;
            border: 1px solid #000;
            background-color: #00000098;
            user-select: none;
            box-sizing: border-box;
            box-shadow: 5px 10px 5px #161616a8;
            h1{
                font-family: "微软雅黑";
                color: #fff;
            }
            /deep/ .el-form-item {
                background-color: unset !important;
            }
            /deep/ .el-input__inner {
                margin-top: 20px;
                background-color: rgba(255, 255, 255, 0.247);
            }
            /deep/ .el-input input {
                color: #fff !important;
            }
            /deep/ .el-input__icon{
                height: 134%;
            }
        }
    }
    
</style>

