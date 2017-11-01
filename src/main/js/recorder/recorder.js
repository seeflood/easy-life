require(['userBehavior'], function () {
    var urlMap = {};
    urlMap["getBrowseUrl"] = "获取电子卷宗浏览地址";
    //加占位符是方便java做代码生成器
    /*{urlMap}*/

    //Hijack $.ajax
    var rawAjax = $.ajax;
    Object.defineProperty($, "ajax", {
        value: function (args) {
            if (args && !args.noRecord) {
                log(args.url, args.data);
            }
            return rawAjax(args);
        }
    });

    function log(url, data) {
        for (key in urlMap) {
            if (url.indexOf(key) < 0) {
                continue;
            }
            //TODO desc目前字段名非中文，和过去不一致
            //且记录所有字段，没过滤
            //可以做个代码生成器，从rap上把要的字段粘进文件，java生成js代码
            // recordUserBehavior(urlMap[key], tanslater.toChineseString(data));
            recordUserBehavior(urlMap[key], data);
            break;
        }
    }

    var tanslater = {
        //加占位符是方便java做代码生成器
        _chinFieldMap:{/*{_chinFieldMap}*/},
        toChineseString: function (obj) {
            var result="";
            for(key in obj){
                var chin=_chinFieldMap[key];
                if(!chin){
                    continue;
                }
                var item=chin+":"+obj[key]+",";
                result+=item;
            }
            result=result.substring(0,result.length-1);
            return result;
        }
    }
});