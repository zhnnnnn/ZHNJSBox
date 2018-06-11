var global = this
;(function() {

// 数据类型处理
global.$rect = function(x,y,w,h) {
    return oc_data_box([x,y,w,h],'rect');
};
global.$size = function(w,h) {
    return oc_data_box([w,h],'size');
};
global.$inset = function(t,l,r,b) {
    return oc_data_box([t,l,r,b],'insets');
};
global.$point = function(x,y) {
    return oc_data_box([x,y],'point');
};
global.$range = function(loc,len) {
    return oc_data_box([loc,len],'range');
};
global.$color = function(color) {
    return oc_color(color);
};
global.$rgb = function(red,green,blue) {
    return oc_color_rgba(red,green,blue);
};
global.$rgba = function(red,green,blue,alpha) {
    return oc_color_rgba(red,green,blue,alpha);
};
global.$font = function(v1,v2) {
    return oc_font(v1,v2);
};
global.$indexPath = function(section,row) {
    return oc_indexpath(section,row);
};

// 获取当前id对应的view
global.$ = function(id) {
    return oc_id_map_view(id);
};

// 定义常数
global.$align = {
    left: 0,
    center: 1,
    right: 2,
    justified: 3,
    natural: 4
};

global.$contentMode = {
    scaleToFill: 0,
    scaleAspectFit: 1,
    scaleAspectFill: 2,
    redraw: 3,
    center: 4,
    top: 5,
    bottom: 6,
    left: 7,
    right: 8,
};

global.$btnType = {
    custom: 0,
    system: 1,
    disclosure: 2,
    infoLight: 3,
    infoDark: 4,
    contactAdd: 5,
};

global.$kbType =  {
    default: 0,
    ascii: 1,
    nap: 2,
    url: 3,
    number: 4,
    phone: 5,
    namePhone: 6,
    email: 7,
    decimal: 8,
    twitter: 9,
    search: 10,
    asciiPhone: 11
};

global.$lineCap = {
    butt: 0,
    round: 1,
    square: 2
};

global.$lineJoin = {
    miter: 0,
    round: 1,
    bevel: 2
};

global.$layout = {
    fill:'fill',
    center:'center',
}

// list删除数据
global._deleteData = function(view,idx) {
    if (idx.hasOwnProperty('row')) {// indexPath
        var section = view.data[indexPath.section];
        if (section) {
            section.row.splice(indexPath.row,1);
            return true;
        }
    }else {
        view.data.splice(idx,1);
        return true;
    }
    return false;
}

//list添加数据
global._insertData = function(view,obj) {
    if (obj.indexPath) {
        var section = view.data[indexPath.section];
        if (section) {
            section.row.splice(indexPath.row,0,obj.value);
            return true;
        }
    }
    if (obj.index) {
        view.data.splice(obj.index,0,obj.value);
        return true;
    }
    return false;
}

// 打印
global.$console = {
    log : function(data) {
        oc_log(data);
    }
};
  
// 添加方法
global.addJsProperty = function(name,property) {
  Object.defineProperty(Object.prototype,name, {value: property,configurable: false, enumerable: false});
}
  
_customMethods = {
    // 布局里的关系
    __lp : function(prop) {
        return oc_LayoutProperty(this,prop);
    },
    // 布局里的方法
    __lr : function(methodName) {
        var slf = this;
        return function() {
            var args = Array.prototype.slice.call(arguments);
            return oc_LayoutRelation(slf,methodName,args[0]);
        };
    },
}

for (var method in _customMethods) {
    if (_customMethods.hasOwnProperty(method)) {
        Object.defineProperty(Object.prototype, method, {value: _customMethods[method], configurable:false, enumerable: false})
    }
}

// 网络请求
global.$http = {
    request : function(data){
        oc_request(data);
    },
    get : function(data) {
        data.method = 'GET';
        oc_request(data);
    },
    post : function(data) {
        data.method = 'POST';
        oc_request(data);
    },
};

// ui展示
global.$ui = {
    render: function(data) {
        oc_ui('render',data);
    },
    push: function(data) {
        oc_ui('push',data);
    },
    alert: function(data) {
        oc_ui('alert',data);
    },
    loading: function(data) {
        oc_ui('loading',data);
    }
};

// 缓存
global.$cache = {
    set : function (string,Object) {
        var data = [string,Object];
        oc_cache('set',data);
    },
    get : function (string) {
        return oc_cache('get',string);
    },
}
})()



