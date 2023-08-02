Feature: Part2 - Verify logic works

	Background:
		* set base url | "http://localhost:6250"
	
  Scenario: Verify add works
    Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Math",
			  "description": "Let's do some math.",
			  "template": "{{num}} + 10 = {{result}}",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "num": {
			        "type": "number"
			      }
			    },
			    "required": [
			      "num"
			    ]
			  },
			  "logic": {
			    "result": {
			      "+": [
			        {
			          "var": "num"
			        },
			        10
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		Given set endpoint | "/templates/:id/process"
		And set header | "Content-Type" "application/json"
		And set request body
		"""
			{
				"num": 10
			}
		"""
		When send request | "post"
		Then verify status | 200
		And verify body | "equals" "10 + 10 = 20"
		
		
	Scenario: Verify subtract works
		Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Math",
			  "description": "Let's do some math.",
			  "template": "{{num}} - 10 = {{result}}",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "num": {
			        "type": "number"
			      }
			    },
			    "required": [
			      "num"
			    ]
			  },
			  "logic": {
			    "result": {
			      "-": [
			        {
			          "var": "num"
			        },
			        10
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		
		Given set endpoint | "/templates/:id/process"
		And set header | "Content-Type" "application/json"
		And set request body
		"""
			{
				"num": 100
			}
		"""
		When send request | "post"
		Then verify status | 200
		And verify body | "equals" "100 - 10 = 90"
		