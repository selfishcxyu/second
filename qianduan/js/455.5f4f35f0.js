"use strict";(self["webpackChunkbylw"]=self["webpackChunkbylw"]||[]).push([[455],{9455:function(t,e,a){a.r(e),a.d(e,{default:function(){return c}});var o=function(){var t=this,e=t._self._c;return e("div",{staticClass:"Complaint"},[e("el-button",{staticStyle:{"margin-bottom":"15px"},attrs:{type:"primary"},on:{click:t.handleAdd}},[t._v("新增报修 "),e("i",{staticClass:"el-icon-circle-plus-outline",staticStyle:{"font-size":"14px"}})]),e("el-dialog",{attrs:{title:"新增公告信息",visible:t.dialogFormVisible,width:"500px"},on:{"update:visible":function(e){t.dialogFormVisible=e}}},[e("el-form",{attrs:{model:t.form,"label-width":"80px"}},[e("el-form-item",{attrs:{label:"投诉人"}},[e("el-input",{attrs:{autocomplete:"off"},model:{value:t.form.nickname,callback:function(e){t.$set(t.form,"nickname",e)},expression:"form.nickname"}})],1),e("el-form-item",{attrs:{label:"门牌号"}},[e("el-input",{attrs:{autocomplete:"off"},model:{value:t.form.doorplate,callback:function(e){t.$set(t.form,"doorplate",e)},expression:"form.doorplate"}})],1),e("el-form-item",{attrs:{label:"报修事件"}},[e("el-input",{attrs:{autocomplete:"off"},model:{value:t.form.event,callback:function(e){t.$set(t.form,"event",e)},expression:"form.event"}})],1)],1),e("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[e("el-button",{on:{click:function(e){t.dialogFormVisible=!1}}},[t._v("取 消")]),e("el-button",{attrs:{type:"primary"},on:{click:t.save}},[t._v("确 定")])],1)],1),e("el-table",{staticStyle:{width:"100%","margin-bottom":"15px"},attrs:{data:t.tableData,stripe:"",border:""}},[e("el-table-column",{attrs:{prop:"id",label:"编号",width:"103"}}),e("el-table-column",{attrs:{prop:"nickname",label:"投诉人",width:"170"}}),e("el-table-column",{attrs:{prop:"doorplate",label:"门牌号",width:"170"}}),e("el-table-column",{attrs:{prop:"event",label:"报修事件",width:"220"}}),e("el-table-column",{attrs:{prop:"time",label:"处理时间",width:"180"}}),e("el-table-column",{attrs:{prop:"state",label:"处理状态",width:"180"},scopedSlots:t._u([{key:"default",fn:function(a){return["未处理"==a.row.state?e("span",{staticClass:"text",staticStyle:{backgroundColor:"#909399"}},[t._v(t._s(a.row.state))]):"已处理"==a.row.state?e("span",{staticClass:"text",staticStyle:{backgroundColor:"#67C23A"}},[t._v(t._s(a.row.state))]):e("span",{staticClass:"text",staticStyle:{backgroundColor:"#E6A23C"}},[t._v(t._s(a.row.state))])]}}])}),e("el-table-column",{attrs:{label:"操作",width:"235"},scopedSlots:t._u([{key:"default",fn:function(a){return[e("el-popconfirm",{staticStyle:{"margin-left":"5px"},attrs:{"confirm-button-text":"确认","cancel-button-text":"再想想",icon:"el-icon-info","icon-color":"red",title:"是否确认已处理？"},on:{confirm:function(e){return t.handleConfirm(a.row.id)}}},["正在处理"==a.row.state?e("el-button",{attrs:{slot:"reference",size:"mini",type:"success"},slot:"reference"},[t._v("确认已处理 "),e("i",{staticClass:"el-icon-edit"})]):t._e()],1),e("el-popconfirm",{staticStyle:{"margin-left":"5px"},attrs:{"confirm-button-text":"确认","cancel-button-text":"再想想",icon:"el-icon-info","icon-color":"red",title:"您确定删除吗？"},on:{confirm:function(e){return t.handleDelete(a.row.id)}}},[e("el-button",{attrs:{slot:"reference",size:"mini",type:"danger"},slot:"reference"},[t._v("删除 "),e("i",{staticClass:"el-icon-remove-outline"})])],1)]}}])})],1),e("el-pagination",{attrs:{"current-page":t.pageNum,"page-sizes":[5,10,15,20],"page-size":t.pageSize,layout:"total, sizes, prev, pager, next, jumper",total:t.total},on:{"size-change":t.handleSizeChange,"current-change":t.handleCurrentChange}})],1)},s=[],i={name:"ComplaintUser",data(){return{tableData:[],pageNum:1,pageSize:5,total:0,user:JSON.parse(sessionStorage.getItem("user"))||"",dialogFormVisible:!1,form:{nickname:"",doorplate:"",pid:"",event:""},residenceInfo:JSON.parse(sessionStorage.getItem("residence"))||""}},created(){this.load()},methods:{handleSizeChange(t){this.pageSize=t,this.load()},handleCurrentChange(t){this.pageNum=t,this.load()},load(){this.request.get("/api/complaint/page",{params:{pageNum:this.pageNum,pageSize:this.pageSize,pid:this.user.id}}).then((t=>{"200"===t.code&&(this.tableData=t.data.records,this.total=t.data.total)}))},handleDelete(t){this.request.delete("/api/complaint/"+t).then((t=>{"200"===t.code?(this.$message.success("删除成功"),this.load()):this.$message.error("删除失败")}))},handleAdd(){this.residenceInfo?(this.form={},this.form.nickname=this.user.nickname,this.form.state="未处理",this.form.pid=this.user.id,this.dialogFormVisible=!0):this.$message.error("您未购置房产，无法申请报修")},save(){this.request.post("/api/complaint",this.form).then((t=>{"200"===t.code?(this.$message.success("新增/编辑成功"),this.dialogFormVisible=!1,this.load()):this.$message.error("新增/编辑失败")}))},handleConfirm(t){const e=new Date,a=e.getFullYear(),o=e.getMonth()+1,s=e.getDate(),i=a+"-"+o+"-"+s;console.log(i.toLocaleString()),this.request.post("/api/complaint",{id:t,time:i.toLocaleString(),state:"已处理"}).then((t=>{"200"===t.code?(this.$message.success("确认处理成功"),this.load()):this.$message.error("操作失败")}))}}},l=i,r=a(1001),n=(0,r.Z)(l,o,s,!1,null,"77c394b5",null),c=n.exports}}]);
//# sourceMappingURL=455.5f4f35f0.js.map