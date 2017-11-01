$(function(){
    $("#importConfig").load("table.txt");
    $("#export").load('sql.txt',function(){
        var _vm = new Vue({
            el: "#haha",
            data: {
                showFlag: false,
                tableName:"T_MS_WY_HTXX",
                tables:[]
            },
            methods:{
                generate:function(){
                    var content=$("#importConfig").val();
                    this.splitContent(content);
                    this.showFlag=true;
                },
                splitContent:function(content){
                    var _this=this;
                    var regex=/^(\w+)\s+字段中文名\s+主键\s+数据类型\s+索引\s+说明/mgi;
                    // var start=0,match;
                    // while(match=regex.exec(content)){
                    //     var table={
                    //         name:match[1],
                    //         columns:[]
                    //     };
                    //     _this.tables.push(table);
                    // }
                    var tableRawArr=content.split(regex);
                    for(var i=1;i<tableRawArr.length;i=i+2){
                        var table={
                            name:tableRawArr[i],
                            columns:[]
                        };
                        _this.tables.push(table);
                        _this.importContent(table,tableRawArr[i+1]);
                    }
                },

                importContent:function(table,str){
                    str=$.trim(str);
                    var _this=this;
                    var regex=/^(\w+)\s+([\u4e00-\u9fa5|\w]+)\s+(\d+)\s+(\S+)\s+(\d+)/mgi;
                    var match;
                    while(match=regex.exec(str)){
                        var item={
                            name:match[1],
                            chin:match[2],
                            isPrimary:match[3]==1,
                            type:_this.typeFormatter(match[4]),
                            isIndex:match[5]==1
                        };
                        table.columns.push(item);
                    }
                },
                copyCode:function(){
                    var code=document.getElementById("export");
                    var content=code.innerText;
                    window.clipboardData.setData("Text",content);
                    alert("复制成功");
                },
                typeFormatter:function(key){
                    if(!key){
                        return;
                    };
                    key=key.replace(/INT/,"INTEGER");
                    key=key.replace(/VC\((\d+)\)/,"VARCHAR($1)");
                    key=key.replace(/DT/,"DATE");
                    return key;
                }
            },
            filters:{

            }
        });
    });
});
