"use strict";(self["webpackChunkbylw"]=self["webpackChunkbylw"]||[]).push([[989],{6989:function(t,e,a){a.r(e),a.d(e,{default:function(){return c}});var l=function(){var t=this,e=t._self._c;return e("div",{staticClass:"Complaint"},[e("div",{staticClass:"search"},[e("el-input",{staticStyle:{width:"200px"},attrs:{placeholder:"搜索投诉人门牌号","prefix-icon":"el-icon-search",clearable:""},model:{value:t.doorplate,callback:function(e){t.doorplate="string"===typeof e?e.trim():e},expression:"doorplate"}}),e("el-button",{staticStyle:{"margin-left":"5px"},attrs:{type:"primary"},on:{click:t.load}},[t._v("搜索")]),e("el-button",{attrs:{type:"warning"},on:{click:function(e){t.doorplate=""}}},[t._v("重置")])],1),e("el-popconfirm",{staticStyle:{"margin-left":"5px"},attrs:{"confirm-button-text":"确认","cancel-button-text":"我再想想",icon:"el-icon-info","icon-color":"red",title:"您确定批量删除这些数据吗？"},on:{confirm:t.delBatch}},[e("el-button",{staticStyle:{margin:"10px 10px 10px 0"},attrs:{slot:"reference",type:"danger"},slot:"reference"},[t._v("批量删除 "),e("i",{staticClass:"el-icon-delete-solid",staticStyle:{"font-size":"14px"}})])],1),e("el-table",{staticStyle:{width:"100%","margin-bottom":"15px"},attrs:{data:t.tableData,stripe:"",border:""},on:{"selection-change":t.handleSelectionChange}},[e("el-table-column",{attrs:{type:"selection",width:"55"}}),e("el-table-column",{attrs:{prop:"id",label:"编号",width:"70"}}),e("el-table-column",{attrs:{prop:"nickname",label:"投诉人",width:"150"}}),e("el-table-column",{attrs:{prop:"doorplate",label:"门牌号",width:"150"}}),e("el-table-column",{attrs:{prop:"pid",label:"投诉人id",width:"80"}}),e("el-table-column",{attrs:{prop:"event",label:"投诉事件",width:"200"}}),e("el-table-column",{attrs:{prop:"time",label:"处理时间",width:"190"}}),e("el-table-column",{attrs:{prop:"state",label:"处理状态",width:"160"},scopedSlots:t._u([{key:"default",fn:function(a){return["未处理"==a.row.state?e("span",{staticClass:"text",staticStyle:{backgroundColor:"#909399"}},[t._v(t._s(a.row.state))]):"已处理"==a.row.state?e("span",{staticClass:"text",staticStyle:{backgroundColor:"#67C23A"}},[t._v(t._s(a.row.state))]):e("span",{staticClass:"text",staticStyle:{backgroundColor:"#E6A23C"}},[t._v(t._s(a.row.state))])]}}])}),e("el-table-column",{attrs:{label:"操作",width:"200"},scopedSlots:t._u([{key:"default",fn:function(a){return[e("el-popconfirm",{staticStyle:{"margin-left":"5px"},attrs:{"confirm-button-text":"确认","cancel-button-text":"我再想想",icon:"el-icon-info","icon-color":"red",title:"是否开启处理？"},on:{confirm:function(e){return t.handle(a.row.id)}}},["未处理"==a.row.state?e("el-button",{attrs:{slot:"reference",size:"mini",type:"info"},slot:"reference"},[t._v("处理 "),e("i",{staticClass:"el-icon-remove-outline"})]):t._e()],1),e("el-popconfirm",{staticStyle:{"margin-left":"5px"},attrs:{"confirm-button-text":"确认","cancel-button-text":"再想想",icon:"el-icon-info","icon-color":"red",title:"您确定删除吗？"},on:{confirm:function(e){return t.handleDelete(a.row.id)}}},[e("el-button",{attrs:{slot:"reference",size:"mini",type:"danger"},slot:"reference"},[t._v("删除 "),e("i",{staticClass:"el-icon-remove-outline"})])],1)]}}])})],1),e("el-pagination",{attrs:{"current-page":t.pageNum,"page-sizes":[5,10,15,20],"page-size":t.pageSize,layout:"total, sizes, prev, pager, next, jumper",total:t.total},on:{"size-change":t.handleSizeChange,"current-change":t.handleCurrentChange}})],1)},o=[],i={name:"Complaint",data(){return{tableData:[],pageNum:1,pageSize:5,total:0,doorplate:"",dialogFormVisible:!1,multipleSelection:[]}},created(){this.load()},methods:{handleSizeChange(t){this.pageSize=t,this.load()},handleCurrentChange(t){this.pageNum=t,this.load()},load(){this.request.get("/api/complaint/page",{params:{pageNum:this.pageNum,pageSize:this.pageSize,doorplate:this.doorplate}}).then((t=>{"200"===t.code&&(this.tableData=t.data.records,this.total=t.data.total,this.$message.success("get notice success"))}))},handle(t){this.request.post("/api/complaint",{id:t,state:"正在处理"}).then((t=>{"200"===t.code?(this.$message.success("开始处理"),this.load()):this.$message.error("操作失败")}))},handleDelete(t){this.request.delete("/api/complaint"+t).then((t=>{"200"===t.code?(this.$message.success("删除成功"),this.load()):this.$message.error("删除失败")}))},handleSelectionChange(t){this.multipleSelection=t},delBatch(){let t=this.multipleSelection.map((t=>t.id));this.request.delete("api/complaint/batch",{data:t}).then((t=>{"200"===t.code?(this.$message.success("批量删除成功"),this.load()):this.$message.error("批量删除失败")}))}}},s=i,n=a(1001),r=(0,n.Z)(s,l,o,!1,null,"0a593f2a",null),c=r.exports}}]);
//# sourceMappingURL=989.1a11d92a.js.map