<?php
//	Class Comma-Separated Value File 
class ModelOpenstockCSV {

    private $config = array();
    private $buffer = NULL;
    private $lines = 0;


    public function init($config = array()) {

        $this->config = array(
            'ext' => '.csv',
            'delimiter' => ',',
            'new_line' => "
",
            'quote_spaces' => TRUE
        );

        $this->initialize($config);
    }

    private function initialize($config) {

        foreach ($config as $key => $val) {
            $this->setConfigItem($key, $val);
        }
    }

    public function setConfigItem($key, $val) {

        if (isset($this->config[$key])) {
            $this->config[$key] = $val;
        }
    }

    public function setHeading($headings) {

        if (!is_array($headings)) {
            $headings = func_get_args();
        }

        $this->buffer = $this->addLine($headings, TRUE) . $this->buffer;
    }


    public function addData($data) {

        foreach ($data as $row) {
            $this->addLine($row);
        }
    }

    public function addLine($row, $heading = FALSE) {

        if (!is_array($row)) {
            $row = func_get_args();
        }

        $row = array_map(array($this, 'delimitField'), $row);

        $this->buffer .= implode($this->config['delimiter'], $row) . $this->config['new_line'];

        if (!$heading)
            $this->lines++;
    }

    private function delimitField($val) {

        // has a quote, quote entire field.
        if (preg_match('/"/', $val)) {
            $val = '"' . str_replace('"', '""', $val) . '"';
        } else {
            // doesnt contain a quote. does it have a comma?
            if (preg_match('/,/', $val)) {
                $val = '"' . $val . '"';
            } else if (preg_match('/(^\s+)|(\s+)|(\s+$)/', $val) && $this->config['quote_spaces']) {
                $val = '"' . $val . '"';
            }
        }

        return $val;
    }

    public function getNumLines() {

        return (int) $this->lines;
    }

    public function clear() {

        $this->buffer = '';
    }

    public function output($destination = 'I', $filename = '') {

        $destination = strtoupper($destination);

        if (empty($filename)) {
            $filename = time() . $this->config['ext'];
        }

        switch ($destination) {

            case 'I': {

                    if (!headers_sent()) {
                        header('Content-Type: text/plain');
                        header('Content-Length: ' . strlen($this->buffer));
                        header('Content-Disposition: inline; filename=' . $filename . '');
                        echo $this->buffer;
                    }
                }
                break;

            case 'D': {

                    if (!headers_sent()) {
                        header('Content-Type: text/csv');
                        header('Content-Length: ' . strlen($this->buffer));
                        header('Content-Disposition: attachment; filename="' . $filename . '"');
                        header('Cache-Control: private, max-age=0, must-revalidate');
                        header('Pragma: public');
                        echo $this->buffer;
                    }
                }
                break;

            case 'F': {
                }
                break;

            case 'S': {
                    return $this->buffer;
                }
                break;
        }
    }

}
?>