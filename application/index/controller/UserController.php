<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 14:41
 */

namespace application\index\controller;


use application\index\model\User;

class UserController
{
    public function getUserName() {
        $user_obj = new User();
        $user_list = $user_obj->getUserList();
        return $user_list;
    }

}