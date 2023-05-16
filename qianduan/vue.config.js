const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  devServer:{
    proxy:{
      "/api":{
        target:"http://localhost:90",
        changeOrigin:true,
        pathRewrite:{
          "^/api":""
        }
      }
    }
  }
})
