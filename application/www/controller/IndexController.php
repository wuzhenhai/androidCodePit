<?php

namespace application\www\controller;

use think\Controller;

class IndexController extends Controller {

    public function index() {
        return  $this->fetch();
    }



}
