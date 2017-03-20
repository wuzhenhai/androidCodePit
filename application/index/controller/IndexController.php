<?php

namespace application\index\controller;

use think\Controller;

class IndexController extends Controller {

    public function index() {
        return  $this->fetch();
    }



}
