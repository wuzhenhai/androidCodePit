<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 15:05
 */

namespace application\index\controller;


use think\Controller;
//接口调用控制器基类
class BaseApiController extends Controller
{
    function _initialize()
    {
        define("KEY","31297l.kjoie3-");
    }
}