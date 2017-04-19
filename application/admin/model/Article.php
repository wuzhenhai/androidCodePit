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
        $res=  $this->order('id', 'asc') ->paginate(10);
        $res=$this->getListData($res);
        return $res;
    }


    public function getListData($article_list)
    {
        foreach ($article_list as $k => $v) {

            //技能
            $skill_obj = new Skill();
            $skill_info = $skill_obj->getSkill($v['skill_id'], 'skill_name');
            $article_list[$k]['skill_name'] = $skill_info['skill_name'];

            //专题名
            $topic_obj = new Topic();
            $topic_info = $topic_obj->getTopicById($v['topic_id']);
            $article_list[$k]['topic_name'] = $topic_info['topic_name'];
        }
        return $article_list;
    }

}
