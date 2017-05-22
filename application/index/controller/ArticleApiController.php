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

    /**
     * 根据条件获取文章列表(LvDom.article.getArticleList)
     * @author mzj
     * @param array
     * @return 成功返回$article_list，失败返回错误码
     */
    public function getArticleList($param) {

        $is_hot = intval($param['is_hot']); // 是否只获取热门文章
        $first_row = intval($param['first_row']); // 开始行，默认0
        $fetch_num = intval($param['fetch_num']); // 获取行数，默认10

        $first_row = $first_row ? $first_row : 0;
        $fetch_num = $fetch_num ? $fetch_num : 10;

        $where = $is_hot ? 'is_hot = 1' : '';//判断是否为推荐

        //根据条件获取列表
        $article_obj = new Article();
        $article_list = $article_obj->getArticleList($where,$first_row,$fetch_num);

        //总数
        $total = $article_obj->getArticleNum($where);

        $article_arr = array(
            'total_num'    => $total ? $total : 0,  //总数
            'nextFirstRow' => $first_row + $fetch_num,  //下一条开始位置
            'article_list' => $article_list,
        );

        return $article_arr;
    }

    /**
     * 获取热门文章列表(LvDom.article.getHotArticleList)
     * @author mzj
     * @param array
     * @return 成功返回$article_list，失败返回错误码
     */
    public function getHotArticleList($param) {

        $is_hot = intval($param['is_hot']); // 是否只获取热门文章
        $first_row = intval($param['first_row']); // 开始行，默认0
        $fetch_num = intval($param['fetch_num']); // 获取行数，默认10

        $first_row = $first_row ? $first_row : 0;
        $fetch_num = $fetch_num ? $fetch_num : 10;

        $is_hot ? 'is_hot = 1' : '';//判断是否为推荐
//        var_dump($is_hot);
//        var_dump($first_row);
//        var_dump($fetch_num);

        $where = $is_hot ? 'is_hot = 1' : '';//判断是否为推荐

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
                ),
                //各种参数
                array(
                    'field'		=> 'first_row',
                    'type'		=> 'string',
                    'required'	=> false,
                    'miss_code'	=> 41008,
                    'empty_code'=> 44008,
                    'type_code'	=> 45008,
                    'func'		=> '',
                    'func_code'	=> 47008,
                ),
                //各种参数
                array(
                    'field'		=> 'fetch_num',
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