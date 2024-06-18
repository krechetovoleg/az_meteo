package com.example.az_meteo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

/**
 * Implementation of App Widget functionality.
 */
class HomeScreenWidget : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {

        for (appWidgetId in appWidgetIds) {

            //val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.home_screen_widget).apply {

                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_container, pendingIntent)

                val currentTemp = widgetData.getString( "currentTemp", null)
                setTextViewText(R.id.currentTemp, currentTemp ?: "Нет данных" )

                val lastTime = widgetData.getString( "lastTime", null)
                setTextViewText(R.id.lastTime, lastTime ?: "Нет данных" )

                val pressure = widgetData.getString( "pressure", null)
                setTextViewText(R.id.pressure, pressure ?: "Нет данных" )

                val humidity = widgetData.getString( "humidity", null)
                setTextViewText(R.id.humidity, humidity ?: "Нет данных" )

                val wind = widgetData.getString( "wind", null)
                setTextViewText(R.id.wind, wind ?: "Нет данных" )
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

