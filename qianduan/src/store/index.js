import Vue from 'vue';
import vuex from 'vuex';
import man from './man';
Vue.use(vuex)

export default new vuex.Store({
    modules:{
        man:man
    }
})



