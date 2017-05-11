<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-11
 * Time: 19:59
 */
namespace application\admin\model;

class Users extends \think\Model
{
    function getUserListForPage($where='',$pre=10){
        return  $this ->where($where)->paginate($pre);
    }

    function getUserList($where=''){
        return  $this ->where($where)->select();
    }


}