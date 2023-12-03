<?php

declare(strict_types=1);

namespace Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class HealthCheckControllerTest extends WebTestCase
{
    public function testHealthZEndpoint(): void
    {
        trigger_deprecation('vendor-name/package-name', '1.3', 'Your deprecation message');
        $client = static::createClient();
        $client->request('GET', '/healthz');

        $this->assertResponseIsSuccessful();
    }
}
