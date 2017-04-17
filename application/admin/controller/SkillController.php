<?php

namespace application\admin\controller;

use application\admin\model\Skill;
use think\Db;


class SkillController extends CommonController {


    public function index()
    {
        $tech = new Skill();
        $res = $tech->getList();

     // 获取分页显示
        $page = $res->render();
        $this->assign('page', $page);

        $this->assign('lists', $res);
        return $this->fetch();
    }


    /**
     * 添加
     */
    public function add()
    {
        $data = input();
        if (empty($data['skill_name'])){
            //$this->error('请填写技能类型');
            exit("name缺失");
        }
        $res = Db::name('skill')->insert($data);
        if ($res) {
            exit("success");
        } else {
            exit("failure");
        }
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
        $res = Db::name('skill')->where($data)->delete();
        if ($res) {
            exit("success");
        } else {
            exit("failure");
        }
    }

    /**
     * 编辑
     */
    public function edit()
    {
        $data = input();
        $tech_obj = new Skill();
        $r = $tech_obj->edit($data['id'],$data);
        if($r){
            exit("success");
        }else {
            exit("fail");
        }
    }


}
