<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/6
 * Time: 17:05
 */

namespace application\index\controller;

use think\Controller;

class ApiController extends Controller
{
    private $api_type;
    private $api_name;
    private $params;

    public function _initialize()
    {
        parent::_initialize();
    }

    function api(){
        $params = $_REQUEST;
        $this->parseRequest();
        $res = $this->callApi($params);
        $this->returnResult(0,$res);
    }


    /**
     * 解析请求的接口类型和接口名
     * @author 姜伟
     * @param void
     * @return void
     * @todo 解析请求的接口类型和接口名，并赋值到$this->api_type和$this->api_name字段
     */
    public function parseRequest()
    {
        $requests       = explode('.', input('request.api_name'));
//        print_r($requests);
//        exit();
        //引入命名空间后的修改
        $this->api_type = __NAMESPACE__."\\".ucfirst($requests[1])."Controller";
        $this->api_name = $requests[2];
    }

    /**
     * 调用接口
     * @author 姜伟
     * @param void
     * @return void
     * @todo 调用接口，$this->api_type为类名，$this->api_name为方法名
     */
    public function callApi($params)
    {
        $obj       = new $this->api_type();
        //var_dump($obj);
        $func_name = $this->api_name;
        return $obj->$func_name($params);
    }


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
