"use strict";(self["webpackChunkbylw"]=self["webpackChunkbylw"]||[]).push([[292],{9292:function(e,t,a){a.r(t),a.d(t,{default:function(){return c}});var i=function(){var e=this,t=e._self._c;return t("div",{staticClass:"staff"},[t("div",{staticClass:"search"},[t("el-input",{staticStyle:{width:"200px"},attrs:{placeholder:"请输入姓名","prefix-icon":"el-icon-search",clearable:""},model:{value:e.name,callback:function(t){e.name="string"===typeof t?t.trim():t},expression:"name"}}),t("el-input",{staticStyle:{width:"200px"},attrs:{placeholder:"请输入职位","prefix-icon":"el-icon-message",clearable:""},model:{value:e.position,callback:function(t){e.position="string"===typeof t?t.trim():t},expression:"position"}}),t("el-button",{staticStyle:{"margin-left":"5px"},attrs:{type:"primary"},on:{click:e.load}},[e._v("搜索")]),t("el-button",{attrs:{type:"warning"},on:{click:function(t){e.name="",e.position=""}}},[e._v("重置")])],1),t("el-button",{staticStyle:{margin:"10px 10px 10px 0"},attrs:{type:"primary"},on:{click:e.handleAdd}},[e._v("新增 "),t("i",{staticClass:"el-icon-circle-plus-outline",staticStyle:{"font-size":"14px"}})]),t("el-dialog",{attrs:{title:"员工信息新增/更新",visible:e.dialogFormVisible,width:"500px"},on:{"update:visible":function(t){e.dialogFormVisible=t}}},[t("el-form",{attrs:{model:e.form,"label-width":"80px"}},[t("el-form-item",{attrs:{label:"姓名"}},[t("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.name,callback:function(t){e.$set(e.form,"name",t)},expression:"form.name"}})],1),t("el-form-item",{attrs:{label:"职位"}},[t("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.position,callback:function(t){e.$set(e.form,"position",t)},expression:"form.position"}})],1),t("el-form-item",{attrs:{label:"月薪"}},[t("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.salary,callback:function(t){e.$set(e.form,"salary",t)},expression:"form.salary"}})],1),t("el-form-item",{attrs:{label:"电话"}},[t("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.phone,callback:function(t){e.$set(e.form,"phone",t)},expression:"form.phone"}})],1),t("el-form-item",{attrs:{label:"pid号"}},[t("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.pid,callback:function(t){e.$set(e.form,"pid",t)},expression:"form.pid"}})],1)],1),t("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[t("el-button",{on:{click:function(t){e.dialogFormVisible=!1}}},[e._v("取 消")]),t("el-button",{attrs:{type:"primary"},on:{click:e.save}},[e._v("确 定")])],1)],1),t("el-table",{staticStyle:{width:"100%","margin-bottom":"15px"},attrs:{data:e.tableData,stripe:"",border:""}},[t("el-table-column",{attrs:{prop:"id",label:"id",width:"80"}}),t("el-table-column",{attrs:{prop:"name",label:"姓名",width:"150"}}),t("el-table-column",{attrs:{prop:"position",label:"职位",width:"150"}}),t("el-table-column",{attrs:{prop:"salary",label:"月薪",width:"80"}}),t("el-table-column",{attrs:{prop:"phone",label:"电话",width:"150"}}),t("el-table-column",{attrs:{prop:"pid",label:"pid号",width:"150"}}),t("el-table-column",{attrs:{label:"操作"},scopedSlots:e._u([{key:"default",fn:function(a){return[t("el-button",{attrs:{size:"mini",type:"success"},on:{click:function(t){return e.handleEdit(a.row)}}},[e._v("编辑 "),t("i",{staticClass:"el-icon-edit"})]),t("el-popconfirm",{staticStyle:{"margin-left":"5px"},attrs:{"confirm-button-text":"确认","cancel-button-text":"我再想想",icon:"el-icon-info","icon-color":"red",title:"您确定删除吗？"},on:{confirm:function(t){return e.handleDelete(a.row.id)}}},["admin"!==a.row.username?t("el-button",{attrs:{slot:"reference",size:"mini",type:"danger"},slot:"reference"},[e._v("删除 "),t("i",{staticClass:"el-icon-remove-outline"})]):e._e()],1)]}}])})],1),t("el-pagination",{attrs:{"current-page":e.pageNum,"page-sizes":[5,10,15,20],"page-size":e.pageSize,layout:"total, sizes, prev, pager, next, jumper",total:e.total},on:{"size-change":e.handleSizeChange,"current-change":e.handleCurrentChange}})],1)},l=[],o={name:"Staff",data(){return{tableData:[],pageNum:1,pageSize:7,total:0,name:"",position:"",dialogFormVisible:!1,form:{name:"",position:"",salary:"",phone:"",pid:""}}},created(){this.load()},methods:{handleSizeChange(e){this.pageSize=e,this.load()},handleCurrentChange(e){this.pageNum=e,this.load()},load(){this.request.get("/api/staff/page",{params:{pageNum:this.pageNum,pageSize:this.pageSize,name:this.name,position:this.position}}).then((e=>{console.log(e),"200"===e.code&&(this.tableData=e.data.records,this.total=e.data.total)}))},handleEdit(e){this.form=e,this.dialogFormVisible=!0},handleDelete(e){this.request.delete("/api/staff/"+e).then((e=>{e?(this.$message.success("删除成功"),this.load()):this.$message.error("删除失败")}))},handleAdd(){this.form={},this.dialogFormVisible=!0},save(){this.form.pid>0&&this.request.post("/api/user",{id:this.form.pid,level:"staff"}).then((e=>{console.log(e),"200"===e.code&&this.$message.success("员工绑定账户成功")})),this.request.post("/api/staff",this.form).then((e=>{"200"===e.code?(this.$message.success("新增/编辑成功"),this.dialogFormVisible=!1,this.load()):this.$message.error("新增/编辑失败")}))}}},s=o,n=a(1001),r=(0,n.Z)(s,i,l,!1,null,"ccebb182",null),c=r.exports}}]);
//# sourceMappingURL=292.8f4c1315.js.map