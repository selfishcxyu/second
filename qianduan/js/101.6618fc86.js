"use strict";(self["webpackChunkbylw"]=self["webpackChunkbylw"]||[]).push([[101],{4101:function(t,e,a){a.r(e),a.d(e,{default:function(){return c}});var i=function(){var t=this,e=t._self._c;return e("div",{staticClass:"Condition"},[e("div",{staticClass:"search"},[e("el-input",{staticStyle:{width:"200px"},attrs:{placeholder:"设施名称","prefix-icon":"el-icon-search",clearable:""},model:{value:t.facility,callback:function(e){t.facility="string"===typeof e?e.trim():e},expression:"facility"}}),e("el-button",{staticStyle:{"margin-left":"5px"},attrs:{type:"primary"},on:{click:t.load}},[t._v("搜索")]),e("el-button",{attrs:{type:"warning"},on:{click:function(e){t.facility=""}}},[t._v("重置")])],1),e("el-button",{staticStyle:{margin:"0 15px 15px 0"},attrs:{type:"primary"},on:{click:t.handleAdd}},[t._v("新增情况汇报 "),e("i",{staticClass:"el-icon-circle-plus-outline",staticStyle:{"font-size":"14px"}})]),e("el-tag",{attrs:{type:"warning"}},[t._v("请确认社区管理的工作情况并汇报")]),e("el-dialog",{attrs:{title:"新增情况汇报信息",visible:t.dialogFormVisible,width:"500px"},on:{"update:visible":function(e){t.dialogFormVisible=e}}},[e("el-form",{attrs:{model:t.form,"label-width":"80px"}},[e("el-form-item",{attrs:{label:"汇报人"}},[e("el-input",{model:{value:t.form.name,callback:function(e){t.$set(t.form,"name",e)},expression:"form.name"}})],1),e("el-form-item",{attrs:{label:"地点"}},[e("el-input",{model:{value:t.form.place,callback:function(e){t.$set(t.form,"place",e)},expression:"form.place"}})],1),e("el-form-item",{attrs:{label:"设备"}},[e("el-input",{attrs:{autocomplete:"off"},model:{value:t.form.facility,callback:function(e){t.$set(t.form,"facility",e)},expression:"form.facility"}})],1),e("el-form-item",{attrs:{label:"情况"}},[e("el-input",{attrs:{autocomplete:"off"},model:{value:t.form.situation,callback:function(e){t.$set(t.form,"situation",e)},expression:"form.situation"}})],1)],1),e("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[e("el-button",{on:{click:function(e){t.dialogFormVisible=!1}}},[t._v("取 消")]),e("el-button",{attrs:{type:"primary"},on:{click:t.save}},[t._v("确 定")])],1)],1),e("el-table",{staticStyle:{width:"100%","margin-bottom":"15px"},attrs:{data:t.tableData,stripe:"",border:""}},[e("el-table-column",{attrs:{prop:"id",label:"id",width:"60"}}),e("el-table-column",{attrs:{prop:"name",label:"汇报人",width:"120"}}),e("el-table-column",{attrs:{prop:"time",label:"汇报时间",width:"180"}}),e("el-table-column",{attrs:{prop:"place",label:"地点",width:"150"}}),e("el-table-column",{attrs:{prop:"facility",label:"设备",width:"150"}}),e("el-table-column",{attrs:{prop:"situation",label:"情况",width:"220"}}),e("el-table-column",{attrs:{label:"操作",width:"200"},scopedSlots:t._u([{key:"default",fn:function(a){return"admin"===t.user.username?[e("el-popconfirm",{staticStyle:{"margin-left":"5px"},attrs:{"confirm-button-text":"确认","cancel-button-text":"再想想",icon:"el-icon-info","icon-color":"red",title:"您确定删除吗？"},on:{confirm:function(e){return t.handleDelete(a.row.id)}}},[e("el-button",{attrs:{slot:"reference",size:"mini",type:"danger"},slot:"reference"},[t._v("删除 "),e("i",{staticClass:"el-icon-remove-outline"})])],1)]:void 0}}],null,!0)})],1),e("el-pagination",{attrs:{"current-page":t.pageNum,"page-sizes":[5,10,15,20],"page-size":t.pageSize,layout:"total, sizes, prev, pager, next, jumper",total:t.total},on:{"size-change":t.handleSizeChange,"current-change":t.handleCurrentChange}})],1)},l=[],o={name:"Condition",data(){return{tableData:[],pageNum:1,pageSize:5,total:0,user:JSON.parse(sessionStorage.getItem("user"))||"",staff:"",facility:"",form:{name:"",time:"",place:"",facility:"",situation:""},dialogFormVisible:!1}},created(){this.load()},methods:{handleSizeChange(t){this.pageSize=t,this.load()},handleCurrentChange(t){this.pageNum=t,this.load()},load(){this.request.get("/api/situation/page",{params:{pageNum:this.pageNum,pageSize:this.pageSize,facility:this.facility}}).then((t=>{"200"===t.code&&(this.tableData=t.data.records,this.total=t.data.total)}))},handleDelete(t){this.request.delete("/api/situation/"+t).then((t=>{"200"===t.code?(this.$message.success("删除成功"),this.load()):this.$message.error("删除失败")}))},handleAdd(){this.form={},this.form.name=this.user.nickname,this.dialogFormVisible=!0},save(){this.request.post("/api/situation",this.form).then((t=>{"200"===t.code?(this.$message.success("新增/编辑成功"),this.dialogFormVisible=!1,this.load()):this.$message.error("新增/编辑失败")}))}}},s=o,r=a(1001),n=(0,r.Z)(s,i,l,!1,null,"6dacd76f",null),c=n.exports}}]);
//# sourceMappingURL=101.6618fc86.js.map