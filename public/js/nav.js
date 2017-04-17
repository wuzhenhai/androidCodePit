/* 
* @Author: ZhangFengJie
* @Date:   2017-03-18 13:21:28
* @Last Modified by:   ZhangFengJie
* @Last Modified time: 2017-03-20 12:06:20
*/

$(document).ready(function(){
    // 所有主色调鼠标高亮元素
    $(".active_mouse").on("mouseover",function(){
        $(this).addClass('active_mouse_active');
    });
    $(".active_mouse").on("mouseout",function(){
        $(this).removeClass('active_mouse_active');
    });
    // 内容区img
    $(".middle_right").height($(".middle_right").width());
    // 活动区背景色
    $(".action_list li").on("mouseover",function(){
        $(this).css("background","#f7f8fa");
    });
    $(".action_list li").on("mouseout",function(){
        $(this).css("background","#fff");
    });
    // 内容区鼠标高亮
    $(".index_list_item").on("mouseover",function(){
        $(this).css("background","#FDFDFD");
    });
    $(".index_list_item").on("mouseout",function(){
        $(this).css("background","#fff");
    });
    $(".aside_list dd").on("mouseover",function(){
        $(this).css("background","#FDFDFD");
    });
    $(".aside_list dd").on("mouseout",function(){
        $(this).css("background","#fff");
    });

    $(".click_nav").on("click",function(){
        $(".nav_row").toggle();
    })

});
    window.onload=function(){
        var window_width =$(window).width();
        if(window_width < 1024){
            var sub_nav_w=0;
            $(".sub_nav_list li").each(function(){
                var li_r=parseInt($(this).css("padding-right"));
                console.log(li_r);
                var li_w=$(this).width();
                console.log(li_w);

                sub_nav_w +=li_r
                sub_nav_w +=li_w
                $(".sub_nav_list").width(sub_nav_w);
            })
        }
    }
