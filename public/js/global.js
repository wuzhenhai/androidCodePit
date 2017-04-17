/* 
* @Author: Marte
* @Date:   2016-12-22 15:26:22
* @Last Modified by:   ZhangFengJie
* @Last Modified time: 2017-03-18 15:55:30
*/
!(function(doc, win) {
    var docEle = doc.documentElement,
        evt = "onorientationchange" in window ? "orientationchange" : "resize",
            fn = function() {
                var window_width =$(window).width();
                if(window_width < 1024){
                    var width = docEle.clientWidth;
                    width && (docEle.style.fontSize = 20 * (width / 375) + "px");
                }else{
                    var width = docEle.clientWidth;
                    width && (docEle.style.fontSize = 15 + "px");
                }
            };
    win.addEventListener(evt, fn, false);
    doc.addEventListener("DOMContentLoaded", fn, false);
    
}(document, window));