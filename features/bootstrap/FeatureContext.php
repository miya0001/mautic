<?php

use Behat\Behat\Hook\Scope\AfterStepScope;
use Behat\Mink\Driver\Selenium2Driver;
use Behat\MinkExtension\Context\RawMinkContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawMinkContext
{
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

    /**
     * Wait for specific seconds.
     * Example:
     * * When I wait for 5 seconds
     * * When I wait for a second.
     *
     * @param int $second The seconds that wait for
     * @Given /^I wait for (?P<second>[0-9]+) seconds$/
     * @Given /^I wait for a second$/
     */
    public function wait_for_second($second = 1)
    {
        $this->getSession()->wait($second * 1000);
    }

    /**
     * @AfterStep
     */
    public function takeScreenShotAfterFailedStep(afterStepScope $scope)
    {
        if (99 === $scope->getTestResult()->getResultCode()) {
            $driver = $this->getSession()->getDriver();
            if (!($driver instanceof Selenium2Driver)) {
                return;
            }
            file_put_contents(
                'tests/screenshot/fail.png',
                $this->getSession()->getDriver()->getScreenshot()
            );
        }
    }
}
