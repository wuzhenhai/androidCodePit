<?php

namespace application\admin\controller;

use application\admin\model\TechGroup;
use think\Db;


class TechController extends CommonController {

    public function index() {
        $res = db('tech_group')->select();
        $this->assign('lists', $res);
        return $this->fetch();
    }



    public function add_tech_info(){
        return $this->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        $data = input();
        if (empty($data['tech_name'])){
            $this->error('请填写技能类型');
        }
        $res = Db::name('tech_group')->insert($data);
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
        if (empty($data['tech_id'])){
            $this->error('id缺失');
        }
        $res = Db::name('tech_group')->where($data)->delete();
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
        $tech_obj = new TechGroup();
        $r = $tech_obj->edit($data['tech_id'],$data);
        if($r){
            exit("success");
        }else {
            exit("failure");
        }
    }


}
