<template>
  <div class="password">
     <el-form :rules="rules" :model="resetPwdForm" ref="resetPwdForm">
        <el-form-item label="旧密码" prop="oldpwd">
            <el-input size="medium" v-model="resetPwdForm.oldpwd"
                 placeholder="  请输入旧密码" prefix-icon="el-icon-user" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="password">
            <el-input size="medium" type="password" v-model="resetPwdForm.password"
                 placeholder="  请输入新密码" :show-password="true" prefix-icon="el-icon-lock" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="确认新密码" prop="passwordC">
            <el-input size="medium" type="password" v-model="resetPwdForm.passwordC"
                 placeholder="  请确认新密码" prefix-icon="el-icon-user" autocomplete="off"></el-input>
        </el-form-item>
        <el-button type="primary" @click="confirmChange" style="margin: 10px 20px 0 0;">确认修改</el-button>
        <el-button type="primary" @click="$router.push('/person')">取消</el-button>
    </el-form>
  </div>
</template>

<script>
export default {
    name:'Password',
    data () {
        //检测旧密码
        const validatePwd = (rule,value,callback) => {
            if(!value){
                callback(new Error("请输入旧密码"))
            }else if(value.toString().length < 3 || value.toString().length > 20){
                callback(new Error("密码长度为3-20"))
            }else if(value !== this.user.password){    //暂时无法获取新密码
                callback(new Error("旧密码输入错误"))
            }else{
                callback()
            }
        }
        //检测新密码
        const validateNewPwd = (rule,value,callback) => {
            if(!value){
                callback(new Error("请输入新密码"))
            }else if(value.toString().length < 3 || value.toString().length > 20){
                callback(new Error("密码长度为3-20"))
            }else if(value === this.resetPwdForm.oldpwd){
                callback(new Error("新旧密码一致！请重新输入..."))
            }else{
                callback()
            }
        }
        //检测第二次输入的新密码
        const validateNewPwdC = (rule,value,callback) => {
            if(!value){
                callback(new Error("请确认密码"))
            }else if(value !== this.resetPwdForm.password){
                callback(new Error("两次密码输入不一致！"))
            }else{
                callback()
            }
        }
        return {
            user:JSON.parse(sessionStorage.getItem("user")),
            resetPwdForm:{
                oldpwd:'',
                password:'',
                passwordC:''
            },
            rules:{
                oldpwd: [
                    { required: true, validator: validatePwd, trigger: 'blur'}
                ],
                password: [
                    { required: true, validator: validateNewPwd, trigger: 'blur'}
                ],
                passwordC: [
                    { required: true, validator: validateNewPwdC, trigger: 'blur'}
                ],
            }
        }
    },
    methods: {
        async confirmChange(){
            let oldPassword = await this.getOldPassword()
            console.log(oldPassword);
            if(this.oldpwd !== oldPassword.data){
                return 
            }
            this.$refs.resetPwdForm.validate(valid => {
                if(valid){
                    this.request.post('/api/user',{id:this.user.id,username:this.user.username,password:this.resetPwdForm.password}).then(res => {
                        console.log(res);
                        if(res.code === '200'){
                            this.$message.success("密码修改成功")
                            this.$router.push('person')
                        }else{
                            this.$message.error("密码修改失败")
                        }
                    })   
                }
            })
        },
        getOldPassword(){
            // this.request.get('/api/user')
        }
    },
}
</script>

<style>

</style>