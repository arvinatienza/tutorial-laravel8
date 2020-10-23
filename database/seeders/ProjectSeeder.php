<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = array(
            array("2020.0512", "Test Project", '0', '1'),
            array("2020.0512001", "Sub Test Project", '1', '1'),
        );

        foreach ($data as $d) {
            DB::table('projects')->insert(
                [
                    'number' => $d[0],
                    'name' => $d[1],
                    'parent_id' => $d[2],
                    'manager_id' => $d[3],
                ]
            );
        }

    }
}
