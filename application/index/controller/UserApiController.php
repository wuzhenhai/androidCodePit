<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 14:41
 */

namespace application\index\controller;


use application\index\model\Api;
use application\index\model\User;
use think\Request;

class UserApiController extends BaseApiController
{
    public function getUserList($param) {
        //直接取PHPSESSID
        $sessid=$_COOKIE['PHPSESSID'];
        //正则匹配取PHPSESSID

//        if ( preg_match('/PHPSESSID=([0-9a-z]+)/i', $cookie, $matches))
//        {
//            $sessid = $matches[1];
//        }

        print_r($sessid);
        exit();
//        $user_list = $user_obj->getUserList();
//        return $user_list;
    }

    public function signup($param){
        $user_obj = new User();
        $username = $param['username'];
        $password = $param['password'];
    }

    public function login($param){
        $user_obj = new User();
        $username = $param['username'];
        $password = $param['password'];
        var_dump($param);

        $user_info = $user_obj->getUserInfo('','username="'.$username.'"');
        if($user_info){
            if($user_info['password'] == $password){
                session("user_id",$user_info['user_id']);
                return array(
                    "user_id" => $user_info['user_id'],
                    "PHPSESSID" => session_id(),
                );
            }else{
                Api::returnResult(1,[],"密码错误");
            }
        }else{
            Api::returnResult(1,[],"用户不存在");
        }
    }

    function getParams($func_name)
    {
        $params = array(
            'login' => array(
                array(
                    'field'		=> 'username',
                    'type'		=> 'string',
                    'required'	=> true,
                    'miss_code'	=> 41008,
                    'empty_code'=> 44008,
                    'type_code'	=> 45008,
                    'func'		=> '',
                    'func_code'	=> 47008,
                ),
                array(
                    'field'		=> 'password',
                    'required'	=> true,
                    'miss_code'	=> 41009,
                    'empty_code'=> 44009,
                    'type_code'	=> 45009,
                    'func'		=> '',
                    'func_code'	=> 47009,
                ),
            ),
        );

        return $params[$func_name];
    }

}