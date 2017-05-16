<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 14:41
 */

namespace application\index\controller;


use application\index\model\User;

class UserApiController extends BaseApiController
{
    public function getUserList($param) {
        $user_obj = new User();
        var_dump($param);
        $user_list = $user_obj->getUserList();
        return $user_list;
    }

}