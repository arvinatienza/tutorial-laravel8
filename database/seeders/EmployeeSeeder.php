<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EmployeeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = array(
            array("Arvin", "Atienza"),
            array("Jin", "Atienza"),
        );

        foreach ($data as $d) {
            DB::table('employees')->insert(
                [
                    'first_name' => $d[0],
                    'last_name' => $d[1],
                ]
            );
        }

    }
}
