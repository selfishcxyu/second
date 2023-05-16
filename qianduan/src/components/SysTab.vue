<template>
  <div class="tab">
    <!-- 通过注入路由，我们可以在任何组件内通过 this.$router 访问路由器，也可以通过 this.$route 访问当前的路由。 -->
    <el-tag
        v-for="(tab,index) in tabList"
        :key="tab.name"
        closable
        @click="tabTo(tab.path)"
        @close="tabClose(tab,index)"
        :effect="tab.name==$route.name ? 'dark' : 'plain'"
    >
        {{tab.name}}
    </el-tag>
  </div>
</template>

<script>
// import {mapState,mapMutations} from 'vuex';
export default {
    name:'SysTab',
    methods: {
        //tab标签点击跳转
        tabTo(path){
            this.$router.push({path:path})
        },
        //点击标签关闭
        tabClose(tab,index){
            this.$store.commit('man/tabClose',tab.path)
            //判断删除的是不是当前那项，不是直接return
            if(tab.name!=this.$route.name) return
            //若删除的是当前那项，判断：若是最后一项，跳转到前一项；若不是最后一项，跳转到前一项
            const length = this.tabList.length
            if(length==index){//删除的是最后一项
                this.$router.push({name:this.tabList[index-1].name})
            }else{//删除的不是最后一项，跳转到最后一项
                this.$router.push({name:this.tabList[length-1].name})
            }
        }
    },
    computed: {
        // ...mapState({
        //     tags:state=>state.tab.tabsList
        // }),
        //实时获取面包屑的数组
        tabList(){
            return this.$store.state.man.tabList
        }
    }
}
</script>

<style lang="less" scoped>
.tab{
    padding: 15px;
    .el-tag{
        cursor: pointer;
        margin-right: 10px;
    }
}
</style>