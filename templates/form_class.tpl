<?='<?php'?>

/**
 * Application Form
 *
 * @package <?=$this->_namespace?>Form
 * @subpackage Form
 * @author <?=$this->_author."\n"?>
 * @copyright <?=$this->_copyright."\n"?>
 * @license <?=$this->_license."\n"?>
 */
<?php if ($this->_addRequire): ?>

/**
 * Zend Form class
 */
require_once 'Zend<?=DIRECTORY_SEPARATOR?>Form.php';
<?php endif; ?>

/**
 * Abstract class that is extended by all tables
 *
 * @package <?=$this->_namespace?>Form
 * @subpackage Form
 * @author <?=$this->_author."\n"?>
 */
class <?=$this->_namespace?>BaseForm extends Zend_Form
{
    /**
     *  @var array Decorators to use for standard form elements
     * these will be applied to our text, password, select, checkbox and radio elements by default
     */
    public $elementDecorators = array(
        'ViewHelper',
        'Errors',
        array('Description', array('tag' => 'p', 'class' => 'description')),
        array('HtmlTag',     array('class' => 'form-div')),
        array('Label',       array('tag'=> 'div', 'class' => 'form-label', 'requiredSuffix' => ' *')),
        array(array('elementDiv' => 'HtmlTag'), array('tag' => 'div', 'class' => 'form-element')),
    );

    /**
     * @var array Decorators for File input elements
     * these will be used for file elements
     */
    public $fileDecorators = array(
        'File',
        'Errors',
        array('Description', array('tag' => 'p', 'class' => 'description')),
        array('HtmlTag',     array('tag' => 'div', 'class' => 'form-div')),
        array('Label',       array('tag' => 'div','class' => 'form-label', 'requiredSuffix' => ' *')),
        array(array('elementDiv' => 'HtmlTag'), array('tag' => 'div', 'class' => 'form-element')),
    );

    /**
     * @var array Decorator to use for standard for elements except do not wrap in HtmlTag
     * this array gets set up in the constructor
     * this can be used if you do not want an element wrapped in a div tag at all
     */
    public $elementDecoratorsNoTag = array();

    /**
     * @var array Decorators for button and submit elements
     * decorators that will be used for submit and button elements
     */
    public $buttonDecorators = array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'div', 'class' => 'form-button'))
    );


    public function __construct()
    {
        /**
         * first set up the $elementDecoratorsNoTag decorator,
         * this is a copy of our regular element decorators, but do not get wrapped in a div tag
         */
        foreach($this->elementDecorators as $decorator) {
            if (is_array($decorator) && $decorator[0] == 'HtmlTag') {
                continue; // skip copying this value to the decorator
            }
            $this->elementDecoratorsNoTag[] = $decorator;
        }

        /**
         * set the decorator for the form itself,
         * this wraps the form elements in a div tag instead of a dl tag
         */
        $this->setDecorators(array(
                             'FormElements',
                             array('HtmlTag', array('tag' => 'div', 'class' => 'form')),
                             'Form'));

        /**
         *
         * set the default decorators to our element decorators,
         * any elements added to the form will use these decorators
         */
        $this->setElementDecorators($this->elementDecorators);

        /**
         * parent::__construct must be called last because it calls $form->init()
         * and anything after it is not executed
         */
        parent::__construct();

    }


    public function addElementClass(&$element, $className, $decorator = null)
    {
        if (!$element instanceof Zend_Form_Element) {
            $element = $this->getElement($element);
        }

        if ($decorator) {
            $decoratorObj = $element->getDecorator($decorator);
            $origClass = $decoratorObj->getOption('class');
            $newClass = $origClass . ' ' . $className;
            $decoratorObj->setOption('class', $newClass);
        } else {
            $origClass = $element->getAttrib('class');
            $newClass = $origClass . ' ' . $className;
            $element->setAttrib('class', $newClass);
        }

        return $this;
    }

        public function render()
    {

        foreach ($this->getElements() as $element) {
            $decorator = $element->getDecorator('Label');
            if ($decorator) {
                if ($element->getLabel()) { // need to check this, since label decorator can be blank
                    $element->setLabel($element->getLabel() . ":&nbsp;");
                }
                $decorator->setOption('escape', false);
            }
            if ($element->getErrors()) {
                $this->addElementClass($element, 'error');

            }
        }

        $output = parent::render();
        return $output;
    }

}
