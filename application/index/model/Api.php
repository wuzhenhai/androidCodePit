<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 15:00
 */

namespace application\index\model;


use think\Model;

class Api  extends Model
{
    /**
     *
     * @author 姜伟
     * @param int $code 返回码
     * @param array $data 返回结果
     * @param string $error_msg 错误说明
     * @return
     * @todo
     */
    static function returnResult($code = 0, $data = array(), $error_msg = '')
    {
        if ($code)
        {
            $return_arr = array(
                'code'		=> $code,
                'error_msg'	=> $error_msg
            );

            exit(json_encode($return_arr));
        }

        $return_arr = array(
            'code'	=> 0,
            'data'	=> $data,
        );
        exit(json_encode($return_arr));	//上线后开启
//        print_r($return_arr);	//调试时开启
//        exit;
    }
}