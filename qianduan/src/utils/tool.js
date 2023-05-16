export default {
     //获取当前时间
     getNowDate(){
        const myDate = new Date()
        const year = myDate.getFullYear()
        const month = myDate.getMonth()-0 + 1 > 10 ? myDate.getMonth()+1 : '0'+ (myDate.getMonth()-0 + 1)
        const day = myDate.getDate() > 10 ? myDate.getDate() : '0'+ myDate.getDate()
        const hours = myDate.getHours() > 10 ? myDate.getHours() : '0'+ myDate.getHours()
        const minutes = myDate.getMinutes() > 10 ? myDate.getMinutes() : '0'+ myDate.getMinutes()
        return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes
      },
      //get on date
      getOnDate(){
        const myDate = new Date()
        const year = myDate.getFullYear()
        const month = myDate.getMonth()-0 + 1 > 10 ? myDate.getMonth()+1 : '0'+ (myDate.getMonth()-0 + 1)
        const day = myDate.getDate() > 10 ? myDate.getDate() : '0'+ myDate.getDate()
        return year + '-' + month + '-' + day
      }
}