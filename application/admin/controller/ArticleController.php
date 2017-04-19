<?php

namespace application\admin\controller;
use application\admin\model\Article;
use application\admin\model\Topic;
use think\Db;

class ArticleController extends CommonController {

    public function index()
    {
        $tech = new Article();
        $res = $tech->getList();
        // 获取分页显示
        $page = $res->render();
        $this->assign('page', $page);

        //获取技能列表
        $topic_obj=new Topic();
        $select_skill_list = $topic_obj->getSkillList();
        $this->assign("skill_list",$select_skill_list);

        $this->assign('lists', $res);
        return $this->fetch();
    }


    /**
     * 添加
     */
    public function add(){
        $data = input();
        $data['create_time']=time();
        $data['user_id']=session('user_id');

        $topic_obj = new Article();
        $r = $topic_obj->allowField(true)->save($data);
        $resp = array();
        if ($r) {
            $resp['success'] = true;
            $resp['code'] = 0;
            exit(json_encode($resp));
        } else {
            $resp['success'] = false;
            $resp['code'] = 1;
            $resp['msg'] = "添加失败";
            exit(json_encode($resp));
        }
    }


    public function get_search_condition()
    {
        $where=array();
        $title = input('request.article_title');
        if ($title){
            $where['article_title']  = ['like','%'.$title.'%'];
            $this->assign('search_title', $title);
        }

        $tech_id = input('request.tech_id');
        if ($tech_id){
            $where['tech_id']  =$tech_id ;
        }

        $module_id = input('request.module_id');
        if ($module_id){
            $where['module_id']  =$module_id ;
        }

        $topic_id = input('request.topic_id');
        if ($topic_id){
            $where['topic_id']  =$topic_id ;
        }

        return $where;
    }


    public function add_article_info(){
        $article_diff_list=Db::name('article_diff') ->select();
        $this->assign("article_diff_list", $article_diff_list);

        $tech_list=Db::name('tech_group')->select();
        $this->assign("tech_list", $tech_list);

//        $module_list=Db::name('module_group')->select();
//        $this->assign("module_list", $module_list);

        $topic_list=Db::name('topic_group')->select();
        $this->assign("topic_list", $topic_list);

        return $this->fetch();
    }


    public function add_article()
    {
        $data = input();
        $tech_id = intval($data['tech_id']);
        $module_id = intval($data['module_id']);
        $topic_id = intval($data['topic_id']);
        $article_diff = intval($data['article_diff']);

        if (!$tech_id || !$module_id || !$topic_id || !$article_diff || !$data['article_title'] || !$data['article_url']) {
            $this->error('参数不齐');
            exit();
        }

        $tech_arr = Db::name('tech_group')->where('tech_id', '=', $tech_id)->field('tech_id,tech_name')->find();

        $module_arr = Db::name('module_group')->where('module_id', '=', $module_id)->field('module_id,module_name')->find();

        $topic_arr = Db::name('topic_group')->where('topic_id', '=', $topic_id)->field('topic_id,topic_name')->find();


        $data = array_merge($data, $tech_arr, $module_arr, $topic_arr);
        $data['user_id'] = session('user_id');
        $data['user_name'] = session('user_name');
        $data['create_time'] = time();
        $res = Db::name('article')->insert($data);

        if ($res) {
            $this->success('添加成功', '/admin/Article/index');
        } else {
            $this->error('添加失败');
            exit();
        }
    }


    public function ajax_tech_list(){
        $module_list=Db::name('module_group')->where('tech_id','=',input('tech_id'))->where('module_id','>',1)->field('module_id,module_name')->select();
        echo json_encode($module_list);
    }

    public function ajax_topic_list(){
        $topic_list=Db::name('Topic')->where('skill_id','=',input('skill_id'))->field('id,topic_name')->select();
        echo json_encode($topic_list);
    }


    public function ajax_module_list(){
        $topic_list=Db::name('topic_group')->where('module_id','=',input('module_id'))->field('topic_id,topic_name')->select();
        echo json_encode($topic_list);
    }



    /**
     * 删除
     */
    public function del()
    {
        $data = input();
        if (empty($data['id'])){
            //$this->error('id缺失');
            exit("id缺失");
        }
        $res = Db::name('article')->where('id ='.$data['id'])->delete();
        if ($res) {
            exit("success");
        } else {
            exit("failure");
        }
    }




    public function hot()
    {
        $data = input();

        if (empty($data['id'])) {
            //$this->error('id缺失');
            exit("id缺失");
        }
        $res = Db::name('article')->where('id =' . $data['id'])->update(['is_hot' => $data['is_hot']]);
        if ($res) {
            exit("success");
        } else {
            exit("failure");
        }
    }

}
