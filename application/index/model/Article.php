<?php
namespace application\index\model;
use think\Model;
/**
 * author   :  mzj
 * createTime: 2017/5/17
 * description:
 */
class  Article extends Model {


//    function __construct(){;
//        $this->name="article";
//    }

    function getArticleList($where='',$offset='',$length=''){
        $article_list=$this->where($where)->order('create_time desc')->limit($offset,$length)->select();

        foreach ($article_list as $k => $v) {
            //获取专题
            $topic_obj=new Topic();
            $topic_id = $v['topic_id'] ? intval($v['topic_id']) : 0;
            $topic_info = $topic_obj->getTopicInfo('id ='.$topic_id,'topic_name');
            $article_list[$k]['topic_name'] = $topic_info['topic_name'];


            //修改时间格式
            $article_list[$k]['create_time']=date("Y-m-d H:i:s",$v['create_time']);
        }
//        var_dump($article_list);
        return  $article_list;
    }


    public function getArticleNum($where = '')
    {
        return $this->where($where)->count();
    }


}