<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 14:41
 */

namespace application\index\controller;

use application\index\model\Article;


class ArticleApiController extends BaseApiController
{

    public function getArticleList($param) {

        $is_hot = intval($param['is_hot']); // 是否只获取热门文章
        $where = $is_hot ? 'is_hot = 1' : '';//判断是否

        $limit=$is_hot ==1?3:'';

        //根据条件获取列表
        $article_obj = new Article();
        $article_list = $article_obj->getArticleList($where,$limit);
        return $article_list;
    }

    //构造验证参数
    function getParams($func_name)
    {
        $params = array(
            //调用方法
            'getArticleList' => array(
                //各种参数
                array(
                    'field'		=> 'is_hot',
                    'type'		=> 'string',
                    'required'	=> false,
                    'miss_code'	=> 41008,
                    'empty_code'=> 44008,
                    'type_code'	=> 45008,
                    'func'		=> '',
                    'func_code'	=> 47008,
                )

            ),
        );

        return $params[$func_name];
    }
}