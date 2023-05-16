<template>
    <div class="contain">
        <div class="login">
            <h1 style="margin:15px 0 30px 0;">社区物业管理系统</h1>
            <el-form :rules="rules" :model="ruleForm" :label-position="labelPosition" ref="ruleForm">
                <el-form-item prop="username">
                    <el-input size="medium" v-model="ruleForm.username" placeholder="  用户名" prefix-icon="el-icon-user" clearable autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input size="medium" type="password" v-model="ruleForm.password" placeholder="  密码" :show-password="true" prefix-icon="el-icon-lock" clearable autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-select v-model="ruleForm.level" placeholder="请选择级别">
                        <el-option label="用户" value="user"></el-option>
                        <el-option label="员工" value="staff"></el-option>
                        <el-option label="管理员" value="admin"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item prop="code">
                    <el-col :span="12">
                        <el-input v-model="ruleForm.code" autocomplete="off" placeholder="请输入验证码" clearable></el-input>
                    </el-col>
                    <el-col :span="12">
                        <div class="loginCode" @click="refreshCode">
                            <!-- 验证码组件 -->    
                            <identify :identifyCode="identifyCode"></identify>
                        </div>
                    </el-col>
                </el-form-item>
                <el-button type="primary" @click="log" style="width: 100%; margin: 0 20px 20px 0;">登录</el-button>
                <el-link type="primary" icon="el-icon-edit" style="float: right;" @click="register">注册...</el-link>
            </el-form>
        </div>
    </div>
</template>

<script>
import identify from "@/utils/Identify.vue"

export default {
    name:'Login',
    components:{ identify },
    data() {
        return {
            labelPosition:'left',
            identifyCodes: '1234567890abcdefjhijklmnopqrstuvwxyz',//随机串内容
            identifyCode: '',
            ruleForm:{
                username:'',password:'',level:'user',code:''
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
                code: [
                    { required: true, message: "请输入验证码", trigger: "blur"},
                    { min:4, max:4, message: '验证码为4位字符,不包含空格', trigger: 'blur' }
                ]
            }
        }
    },
    mounted () {
        //不管有没有获得焦点，键盘事件都有效。在页面创建时添加键盘弹起时事件
        document.addEventListener('keyup', e => {
            let key = window.event.keyCode
            if(key==13){
                this.log()
            }
        })
        this.refreshCode()
    },
    methods:{
        //刷新验证码随机数
        refreshCode(){
            this.identifyCode = ''
            this.makeCode(4)
        },
        //从字典随机选取len个随机数的组合
        makeCode(len){
            for(let i = 0; i < len; i++){
                this.identifyCode += this.identifyCodes[this.randomNum(0,this.identifyCodes.length)]
            }
        },
        //获取0到max-min间的随机数再加min就是min到max间的随机数
        randomNum(min,max){
            return Math.floor(Math.random() * (max-min) + min)
        },
        log(){
            //提交前表单认证
            this.$refs.ruleForm.validate((valid) => {
                if(this.ruleForm.code !== this.identifyCode){
                    this.$message.error("验证码错误")
                    this.refreshCode()
                    return 
                }
                if(valid) {
                    this.request.post('api/user/login',this.ruleForm).then(res => {
                        if(res.code === '200'){
                            //用户信息存入浏览器
                            res.data.password = ''
                            sessionStorage.setItem("user",JSON.stringify(res.data))
                            
                            this.$store.commit('man/tabListAdd',{
                                path:'home',
                                name:"首页"
                            })
                            //获取菜单信息（身份在上面辨别，在这只需传入level以获取菜单权限）
                            this.request.get('/api/menu/'+this.ruleForm.level).then(value => {
                                if(value.code==='200'){
                                    const menu = value.data
                                    menu.unshift({ //前面添加主页的路径
                                        path:'home',name:'首页',icon:'s-home'
                                    })
                                    ///组装多级菜单
                                    // const menu = value.data
                                    // menu.map(item=>{
                                    //     if(item.url.split('/')[1]){
                                    //         console.log("split");
                                    //     }
                                    // })
                                    ///菜单数据在data.data.menu，获取菜单数据存入store/state/menuList，传入sessionStorage
                                    sessionStorage.setItem("menu",JSON.stringify(value.data))
                                    //把路由传递给mutations，动态添加
                                    this.$store.commit('man/addMenu',this.$router)
                                }
                            })
                            //添加上判断可以刷新的标识
                            sessionStorage.setItem("refresh",true)
                            console.log("home");
                            this.$router.push('/home')
                            this.$message.success("login success")
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
        register(){
            this.$router.push('/register')
        }
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
        .login{
            margin: 160px auto;
            width: 400px;
            height: 500px;
            text-align: center;
            padding: 5px 40px;
            border: 1px solid #000;
            background-color: #00000098;
            user-select: none;
            box-sizing: border-box;
            box-shadow: 5px 10px 5px #161616a8;
            .loginCode{
                margin: 15px auto;
                border-radius: 10px;
            }
            h1{
                font-family: "微软雅黑";
                color: #fff;
            }
            /deep/ .el-form-item {
                background-color: unset !important;
            }
            /deep/ .el-input__inner {
                margin-top: 15px;
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

