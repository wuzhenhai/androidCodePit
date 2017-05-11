<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-11
 * Time: 19:58
 */

namespace application\admin\controller;


use application\admin\model\Users;

class UserController extends CommonController
{
    public function index(){
        $pre_page_num = 10;
        $user_list_obj = new Users();
        $user_list = $user_list_obj->getUserListForPage('',$pre_page_num);
//        var_dump(json_encode($user_list));
        // 获取分页显示
        $page = $user_list->render();
        $this->assign('page', $page);
        $this->assign("user_list",$user_list);
        return $this->fetch();
    }

}