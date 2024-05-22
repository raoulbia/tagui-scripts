// https://github.com/kelaberetiv/TagUI/issues/485

// return 2-character string
function pad2(n) { 
    return (n < 10 ? '0' : '') + n;
}

// return YYMMDDHHMMSS string
function timestamp() { 
    var d = new Date();
    return d.getFullYear().toString() +
        pad2(d.getMonth() + 1) +
        pad2(d.getDate()) 
        //pad2(d.getHours()) + ":" +
        //pad2(d.getMinutes()) //+
        //pad2(d.getSeconds())
        ;
}

// return YY/MM/DD string
function timestamp2() { 
    var d = new Date();
    return d.getFullYear().toString() + '/' +
        pad2(d.getMonth() + 1) + '/' +
        pad2(d.getDate()) 
        //pad2(d.getHours()) + ":" +
        //pad2(d.getMinutes()) //+
        //pad2(d.getSeconds())
        ;
}
