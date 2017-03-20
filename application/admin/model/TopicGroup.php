<?php

/**
 *  
 * @file   AdminGroup.php  
 * @date   2016-8-30 18:22:31 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\model;
use think\Db;
use think\Model;

class TopicGroup extends Model {

    public function getGroups()
    {
        $topiclist = $this  ->order('topic_id', 'asc') ->select();
        return $topiclist;
    }

    public function addTopic($data)
    {
       return $this->insertGetId($data);
    }

}
