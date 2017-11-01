var _vm = new Vue({
    el: "#haha",
    data: {
        showFlag: false,
        urlMap: [],
        chinFields:{
            "ah":"案号"
        }
    },
    methods:{
        generate:function(){
            var content=$("#importConfig").val();
            this.importUrlMap(content);
            this.importChinFields(content);
            this.showFlag=true;
        },
        importUrlMap:function(str){
            var regex=/^接口名称\s+([\u4e00-\u9fa5]+)[.\n]*?请求Url\s+([a-z|/]+)/mgi;
            while(match=regex.exec(str)){
                var urlShort=match[2];
                urlShort=urlShort.substring(urlShort.lastIndexOf('/')+1,urlShort.length);
                this.urlMap.push({
                    url:urlShort,
                    what:match[1]
                })
            }
        },
        importChinFields:function(str){
            var regex=/^(\w+)\s+([\u4e00-\u9fa5]+)/mgi;
            while(match=regex.exec(str)){
                this.chinFields[match[1]]=match[2];
            }
        },
        copyCode:function(){
            var code=document.getElementById("haha");
            var content=code.innerHTML;
            window.clipboardData.setData("Text",content);
            alert("复制成功");
        }
    }
});
