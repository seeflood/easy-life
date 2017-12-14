function custom() {
    console = console || {};
    if (console.watch) {
        return;
    }
    console.watch = function (obj, prop) {
        //wish no conflict!
        privateProp = "!@#" + prop + "!@#";
        obj[privateProp] = obj[prop];
        Object.defineProperty(obj, prop, {
            get: function () {
                return obj[privateProp];
            },
            set: function (value) {
                debugger
                obj[privateProp] = value;
            }
        });
    }

}

function appendMyFunction(func) {
    var script = document.createElement("script");
    var code = document.createTextNode('(' + func + ')();');
    script.appendChild(code);
    (document.body || document.head || document.documentElement).appendChild(script);
}

appendMyFunction(custom);
