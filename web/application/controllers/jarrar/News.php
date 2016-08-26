<?php
class News extends CI_Controller {

	const MY_PATH = 'jarrar/news';
	
    public function __construct()
    {
            parent::__construct();
            $this->load->model('jarrar/news_model');
            $this->load->helper('url_helper');
    }

    public function index()
    {
        $data['news'] = $this->news_model->get_news();
        $data['title'] = 'News archive';


        $this->load->view('templates/header', $data);
        $this->load->view(self::MY_PATH.'/index', $data);
        $this->load->view('templates/footer');		
    }

    public function view($slug = NULL)
    {
        $data['news_item'] = $this->news_model->get_news($slug);

        if (empty($data['news_item']))
        {
                show_404();
        }

        $data['title'] = $data['news_item']['title'];

        $this->load->view('templates/header', $data);
        $this->load->view(self::MY_PATH.'/view', $data);
        $this->load->view('templates/footer');
    }
}