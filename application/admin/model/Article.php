<?php

/**
 *  
 * @file   AdminGroup.php  
 * @date   2016-8-30 18:22:31 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\model;


class Article extends \think\Model {

    public function getList() {
       $res=  $this->order('article_id', 'asc')  ->select();
        return $res;
    }



//    public function getGroupName($group_id) {
//        return db('article_group')->where(['article_id' => $group_id])->value('article_name');
//    }




}
