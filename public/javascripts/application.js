function changeWebsiteHeight(height){
	height = height<getClientHeight() ? getClientHeight() : height;
	document.getElementById('website').style.height=height;
}
/*
function getPageHeight(){
	var height=(document.height!==undefined)?document.height:document.body.offsetHeight;
	return height;
}
*/

function getPageHeight(){
    
    var  yScroll,windowHeight,pageHeight;
    
    if (window.innerHeight && window.scrollMaxY) {            
        yScroll = window.innerHeight + window.scrollMaxY;
    } else if (document.body.scrollHeight > document.body.offsetHeight){        
        yScroll = document.body.scrollHeight;
    } else {        
        yScroll = document.body.offsetHeight;
    }
    
    if (self.innerHeight) {        
        windowHeight = self.innerHeight;
    } else if (document.documentElement && document.documentElement.clientHeight) {
        windowHeight = document.documentElement.clientHeight;
    } else if (document.body) {
        windowHeight = document.body.clientHeight;
    }    
    
    if(yScroll < windowHeight){
        pageHeight = windowHeight;
    } else {
        pageHeight = yScroll;
    }

    return pageHeight
}

function getClientHeight(){
	var height=(document.clientHeight!==undefined)?document.height:document.body.clientHeight;
	return height;
}

function getClientWidth(){
	var width=(document.clientWidth!==undefined)?document.width:document.body.clientWidth;
	return width;
}

function getScrollTop(){
	var scrollTop= document.body.scrollTop || window.pageYOffset ||document.documentElement.scrollTop;
	return scrollTop;
}

function getPageHeightAndScrollTopAndClientHeight(){
	var obj=new Object();
	obj.pageHeight=getPageHeight();
	obj.scrollTop=getScrollTop();
	obj.clientHeight=getClientHeight();
	obj.clientWidth=getClientWidth();
	return obj;
}
