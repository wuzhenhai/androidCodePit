<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 14:42
 */

namespace application\index\model;

use think\Model;

class User extends Model
{
    function __construct(){;
        $this->name="users";
    }

    function getUserList($where=''){
        return  $this ->where($where)->select();
    }
}